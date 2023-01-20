//
//  Data+Extension.swift
//  NetworkingAlamofireSolution
//
//  Created by Nikita Omelchenko on 20.10.2021.
//

import Foundation

public extension Data {
    var toString: String {
        String(decoding: self, as: UTF8.self)
    }

    func convertToDictionary() -> [String: AnyObject]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? [String: AnyObject]
        } catch _ as NSError {
            return nil
        }
    }
}
