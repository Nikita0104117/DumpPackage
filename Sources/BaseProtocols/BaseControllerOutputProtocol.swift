//
//  BaseControllerOutputProtocol.swift
//
//
//  Created by Nikita Omelchenko
//

protocol BaseControllerOutput: AnyObject {
    func didLoad()
    func didAppear()
    func didDisappear()
    func willAppear()
    func willDisappear()
}

extension BaseControllerOutput {
    func didLoad() {}
    func didAppear() {}
    func didDisappear() {}
    func willAppear() {}
    func willDisappear() {}
}
