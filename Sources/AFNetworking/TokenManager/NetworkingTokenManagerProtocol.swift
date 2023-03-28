//
//  TokenStoreExtension.swift
//  NetworkingAlamofireSolution
//
//  Created by Nikita Omelchenko on 20.10.2021.
//

// MARK: - Token Protocol

public protocol TokenProtocol: AnyObject {
    typealias Tokens = TokenManager.TokensModel

    func updateToken(_ tokens: Tokens?)
}

// MARK: - Extension NetworkingRouter

public extension TokenManager {
    enum TokenRouter {
        case refreshToken(TokenManager.TokensModel)
    }
}
