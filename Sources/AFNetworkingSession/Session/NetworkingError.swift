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

