//
//  NetworkingSession.swift
//  NetworkingAlamofireSolution
//
//  Created by Nikita Omelchenko on 18.10.2021.
//

import Foundation
import Alamofire

open class NetworkingSession: NetworkingSessionProtocol {
    private var baseURL: URL?

    private let eventMonitor: BaseEventMonitor = .init()
    private let requestInterceptor: BaseRequestInterceptor = .init()

    private let rootQueue: DispatchQueue
    private let requestQueue: DispatchQueue
    private let serializationQueue: DispatchQueue
    private let configuration: URLSessionConfiguration

    private let authenticator = OAuthAuthenticator()
    private var authInterceptor: AuthenticationInterceptor<OAuthAuthenticator>?

    public var authCredential: OAuthAuthenticator.OAuthCredential? {
        didSet {
            guard
                let authCredential = authCredential
            else {
                authInterceptor = nil
                return
            }

            authInterceptor = .init(authenticator: authenticator, credential: authCredential)
        }
    }

    public weak var authDelegate: OAuthAuthenticatorDelegate? {
        didSet {
            authenticator.delegate = authDelegate
        }
    }

    public weak var interceptorDelegate: InterceptorDelegate? {
        didSet {
            requestInterceptor.delegate = interceptorDelegate
        }
    }

    public private(set) var sessionManager: Session

    public private(set) var decoder: JSONDecoder = JSONDecoder()
    public private(set) var encoder: JSONEncoder = JSONEncoder()

    public init(baseURL: String) {
        self.baseURL = URL(string: baseURL)

        self.rootQueue = DispatchQueue(label: "\(baseURL).\(Bundle.main.bundleIdentifier ?? "").rootQueue")
        self.requestQueue = DispatchQueue(label: "\(baseURL).\(Bundle.main.bundleIdentifier ?? "").requestQueue")
        self.serializationQueue = DispatchQueue(label: "\(baseURL).\(Bundle.main.bundleIdentifier ?? "").serializationQueue")

        self.configuration = URLSessionConfiguration.af.default
        self.configuration.timeoutIntervalForRequest = 30
        self.configuration.waitsForConnectivity = true
        self.configuration.requestCachePolicy = .reloadRevalidatingCacheData

        self.sessionManager = .init(
            configuration: configuration,
            rootQueue: rootQueue,
            startRequestsImmediately: true,
            requestQueue: requestQueue,
            serializationQueue: serializationQueue,
            interceptor: requestInterceptor,
            cachedResponseHandler: ResponseCacher(behavior: .cache),
            eventMonitors: [ eventMonitor ]
        )

        self.commonSetup()
    }

    private func commonSetup() {
        configurateDecoder()
        configurateEncoder()
    }

    private func configurateDecoder() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
    }

    private func configurateEncoder() {
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .secondsSince1970
        encoder.outputFormatting = .prettyPrinted
    }

    public func request(_ type: NetworkingRouterProtocol) -> DataRequest? {
        guard let baseURL = baseURL else { return nil }

        let parameters: Parameters? = type.parameters?.asDictionary(encoder: self.encoder)

        return sessionManager.request(
            baseURL.appendingPathComponent(type.path),
            method: type.method,
            parameters: parameters,
            encoding: type.encoder,
            headers: type.headers,
            interceptor: type.addAuth ? authInterceptor : nil
        )
    }

    public func uploadFile(_ type: UploadRouterProtocol) -> DataRequest? {
        guard
            let baseURL = baseURL,
            let inputStream = InputStream(url: type.fileURL)
        else {
            return nil
        }

        return sessionManager.upload(
            multipartFormData: {
                $0.append(
                    inputStream,
                    withLength: UInt64(type.fileURL.fileSize),
                    name: type.fileName,
                    fileName: "\(type.fileName)\(type.fileType)",
                    mimeType: type.mimeType
                )
            },
            to: baseURL.appendingPathComponent(type.path),
            method: type.method,
            headers: type.headers,
            interceptor: type.addToken ? authInterceptor : nil
        )
    }

    public func objectfromData<T: Decodable>(_ data: Data) -> T? {
        do {
            let object = try self.decoder.decode(T.self, from: data)
            return object
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}

private extension Encodable {
    func asDictionary(encoder: JSONEncoder) -> [String: Any]? {
        do {
            let data = try encoder.encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]

            return dictionary
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}
