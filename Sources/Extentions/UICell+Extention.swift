//
//  UICell+Extention.swift
// AdidasTestProject
//
//  Created by Nikita Omelchenko on 07.05.2022.
//

import UIKit

public extension UITableViewCell {
    static var reusebleId: String {
        String(describing: Self.self)
    }
}

public extension UITableView {
    func register(_ cellClass: UITableViewCell.Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.reusebleId)
    }
}

public extension UICollectionViewCell {
    static var reusebleId: String {
        String(describing: Self.self)
    }
}

public extension UICollectionView {
    func register (_ cellClass: UICollectionViewCell.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.reusebleId)
    }
}
