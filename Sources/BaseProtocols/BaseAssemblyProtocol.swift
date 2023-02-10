//
//  BaseAssemblyProtocol.swift
//
//
//  Created by Nikita Omelchenko
//

import UIKit

public protocol BaseAssembly {
    func assemble() -> UIViewController
}

extension BaseAssembly {
    func assemble() -> UIViewController { .init() }
}
