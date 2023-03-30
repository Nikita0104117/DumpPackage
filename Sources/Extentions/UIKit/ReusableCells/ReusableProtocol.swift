//
//  UIStackView+Extension.swift
//  Dump
//
//  Created by Vyacheslav on 30.03.2023.
//

import UIKit

public protocol Reusable: AnyObject {
    static var reusebleId: String { get }
}

public extension Reusable {
    static var reusebleId: String {
        String(describing: Self.self)
    }
}

extension UITableViewCell: Reusable { }
extension UICollectionViewCell: Reusable { }
