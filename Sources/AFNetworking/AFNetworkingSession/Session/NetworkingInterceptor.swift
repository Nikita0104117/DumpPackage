//
//  NetworkingInterceptor.swift
//  NetworkingAlamofireSolution
//
//  Created by Nikita Omelchenko on 18.10.2021.
//

import Foundation
import Alamofire

final class BaseRequestInterceptor: RequestInterceptor {
    public weak var delegate: InterceptorDelegate?

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        guard
            let delegate = delegate
        else {
            completion(.success(urlRequest))
            return
        }

        debugPrint("==========================")
        debugPrint("🏃🏼‍♂️ \(urlRequest.httpMethod ?? "nil") \(urlRequest.debugDescription)")
        debugPrint("🔸 Header: \(urlRequest.allHTTPHeaderFields?.debugDescription ?? "nil")")
        debugPrint("🔸 Parameters: \(urlRequest.httpBody?.toString ?? "nil")")
        debugPrint("==========================")

        delegate.adapt(urlRequest, completion: completion)
    }

    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard
            request.response?.status != .ok
        else {
            completion(.doNotRetry)
            return
        }

        debugPrint("==========================")
        debugPrint("❌ Failure: \(request.description)")
        debugPrint("🔄 Retry count: \(request.retryCount)")
        debugPrint("🔸 Error: \(error.localizedDescription)")
        debugPrint("==========================")

        guard
            let delegate = delegate
        else {
            completion(.doNotRetry)
            return
        }

        delegate.retry(request, dueTo: error, completion: completion)
    }
}
