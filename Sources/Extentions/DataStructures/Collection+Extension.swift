//
//  Collection+Extension.swift
//  JoinLearners
//
//  Created by Vyacheslav on 19.08.2022.
//

public extension Collection {
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
