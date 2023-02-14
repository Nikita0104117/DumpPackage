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

public extension BaseAssembly {
    func assemble() -> UIViewController { .init() }
}
