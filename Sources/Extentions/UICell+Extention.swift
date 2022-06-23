//
//  UICell+Extention.swift
// AdidasTestProject
//
//  Created by Nikita Omelchenko on 07.05.2022.
//

import UIKit

extension UITableViewCell {
    static var reusebleId: String {
        String(describing: Self.self)
    }
}

extension UITableView {
    func register(_ cellClass: UITableViewCell.Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.reusebleId)
    }
}

extension UICollectionViewCell {
    static var reusebleId: String {
        String(describing: Self.self)
    }
}

extension UICollectionView {
    func register (_ cellClass: UICollectionViewCell.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.reusebleId)
    }
}
