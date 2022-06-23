//
//  BaseAlamofire.swift
//  NetworkingAlamofireSolution
//
//  Created by Nikita Omelchenko on 18.10.2021.
//

import Foundation
import Alamofire

enum RequestRouter { }

// MARK: - Networking Router Protocol
public protocol NetworkingRouterProtocol {
    typealias Endpoint = String

    var path: Endpoint { get }
    var method: HTTPMethod { get }
    var parameters: Encodable? { get }
    var encoder: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
    var addAuth: Bool { get }
}

extension NetworkingRouterProtocol {
    var method: HTTPMethod { .get }
    var parameters: Encodable? { nil }
    var headers: HTTPHeaders? { nil }
    var addAuth: Bool { false }

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
