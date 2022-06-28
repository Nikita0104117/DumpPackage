//
//  UploadRouterProtocol.swift
//  NetworkingAlamofireSolution
//
//  Created by Nikita Omelchenko on 20.10.2021.
//

import Foundation
import Alamofire

// MARK: - Upload File Router Protocol
public protocol UploadRouterProtocol {
    typealias Endpoint = String

    var fileURL: URL { get }
    var fileName: String { get }
    var fileType: String { get }
    var mimeType: String { get }

    var path: Endpoint { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var addToken: Bool { get }
}

public extension UploadRouterProtocol {
    var method: HTTPMethod { .post }
    var headers: HTTPHeaders? { nil }
    var addToken: Bool { false }
}
