//
//  BaseControllerOutputProtocol.swift
//
//
//  Created by Nikita Omelchenko
//

public protocol BaseControllerOutput: AnyObject {
    func didLoad()
    func didAppear()
    func didDisappear()
    func willAppear()
    func willDisappear()
}

public extension BaseControllerOutput {
    func didLoad() {}
    func didAppear() {}
    func didDisappear() {}
    func willAppear() {}
    func willDisappear() {}
}
