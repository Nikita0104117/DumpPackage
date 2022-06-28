//
//  Collection+Extension.swift
//  
//
//  Created by Nikita Omelchenko on 28.06.2022.
//

import Foundation

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
