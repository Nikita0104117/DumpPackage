//
//  BaseAlamofire.swift
//  NetworkingAlamofireSolution
//
//  Created by Nikita Omelchenko on 18.10.2021.
//

import Foundation
import Alamofire

public enum RequestRouter { }

// MARK: - Networking Router Protocol
public protocol NetworkingRouterProtocol {
    typealias Endpoint = String

    var path: Endpoint { get }
    var method: HTTPMethod { get }
    var parameters: Encodable? { get }
    var encoder: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
    var addAuth: Bool { get }
    var data: Data? { get }
}

public extension NetworkingRouterProtocol {
    var parameters: Encodable? { nil }
    var headers: HTTPHeaders? { ["Accept": "application/json"] }
    var addAuth: Bool { false }
    var data: Data? { nil }

    var encoder: ParameterEncoding {
        switch method {
            case .get:
                return URLEncoding.default
            case .post:
                return JSONEncoding.default
            default:
                return JSONEncoding.default
        }
    }
}
