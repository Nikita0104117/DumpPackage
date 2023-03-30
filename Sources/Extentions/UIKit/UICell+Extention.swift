//
//  UIStackView+Extension.swift
//  Dump
//
//  Created by Vyacheslav on 30.03.2023.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.reusebleId)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        dequeueReusableCell(T.self, for: indexPath)
    }

    func dequeueReusableCell<T: UITableViewCell>(
        _ cellClass: T.Type,
        for indexPath: IndexPath
    ) -> T? {
        dequeueReusableCell(withIdentifier: cellClass.reusebleId, for: indexPath) as? T
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.reusebleId)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        dequeueReusableCell(T.self, for: indexPath)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(
        _ cellClass: T.Type,
        for indexPath: IndexPath
    ) -> T? {
        dequeueReusableCell(withReuseIdentifier: cellClass.reusebleId, for: indexPath) as? T
    }
}
