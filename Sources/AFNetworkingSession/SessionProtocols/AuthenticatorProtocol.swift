//
//  AuthenticatorProtocol.swift
//  NetworkingAlamofireSolution
//
//  Created by Nikita Omelchenko on 20.10.2021.
//

import Foundation
import Alamofire

// MARK: - OAuthAuthenticatorDelegate
public protocol OAuthAuthenticatorDelegate: AnyObject {
    typealias AuthCredential = OAuthAuthenticator.OAuthCredential

    func apply(_ credential: AuthCredential, to urlRequest: inout URLRequest)
    func refresh(
        credential: AuthCredential,
        completion: @escaping (Result<AuthCredential, Error>) -> Void
    )
    func didRequest( _ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool
    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: AuthCredential) -> Bool
}

extension OAuthAuthenticatorDelegate {
    func apply(_ credential: AuthCredential, to urlRequest: inout URLRequest) { }

    func refresh(
        credential: AuthCredential,
        completion: @escaping (Result<AuthCredential, Error>) -> Void
    ) { }

    func didRequest( _ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
        false
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: AuthCredential) -> Bool {
        true
    }
}
