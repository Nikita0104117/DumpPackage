//
//  NetworkingError.swift
//  
//
//  Created by Nikita Omelchenko on 20.01.2023.
//

import Foundation

public enum NetworkingError: Error {
    case customError(String)
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .customError(let string):
            return string
        }
    }
}

// MARK: - Server Error Example
// {"message":"The given data was invalid.","errors":{"first_name":["The first name field is required."],"last_name":["The last name field is required."]}}

// {"message":"The given data was invalid.","errors":{"message":["Old password error"]}}

// MARK: - ServerError
public typealias ServerError = Decodable & Error

// MARK: - ErrorObject
public struct ErrorObject: ServerError {
    let message: String
    let errors: [String:[String]]
}
