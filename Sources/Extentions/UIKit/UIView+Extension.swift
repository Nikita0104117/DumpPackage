//
//  File.swift
//  
//
//  Created by Nikita Omelchenko on 06.02.2023.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
