//
//  BaseViewProtocols.swift
//  
//
//  Created by Nikita Omelchenko on 28.06.2022.
//

import UIKit

public protocol BaseViewOutput {
    var view: UIView { get }
}

public extension BaseViewOutput where Self: UIView {
    var view: UIView { self }
}
