//
//  Dictionary+Extension.swift
//  JoinLearners
//
//  Created by Vyacheslav on 19.08.2022.
//

public extension Dictionary {
    subscript (safe key: Key) -> Value? {
        index(forKey: key) == nil ? nil : self[key]
    }
}
