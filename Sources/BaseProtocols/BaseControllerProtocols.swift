//
//  BaseControllerProtocols.swift
//  
//
//  Created by Nikita Omelchenko on 28.06.2022.
//

import UIKit
import AFNetworkingUI

public protocol BaseControllerProtocol {
    associatedtype P
    associatedtype V

    var output: P? { get set }
    var viewOutput: V? { get set }
}

public protocol BaseControllerInput: AnyObject {
    func showNetworking(error text: String?)
    func showNetworking(info text: String?)
    func showActivity()
    func hideActivity()
    func showActivity(delay: CGFloat)
}

public extension BaseControllerInput where Self: UIViewController {
    func showNetworking(error text: String?) {
        NetworkingMassage.showMassege(viewController: self, text: text, style: .failure)
    }

    func showNetworking(info text: String?) {
        NetworkingMassage.showMassege(viewController: self, text: text, style: .success)
    }

    func showActivity(delay: CGFloat) {
        showActivity()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.hideActivity()
        }
    }

    func showActivity() {
        NetworkingActivity.show(viewController: self, color: .black, type: .circleStrokeSpin)
    }

    func hideActivity() {
        NetworkingActivity.hide()
    }
}

public protocol BaseControllerOutput: AnyObject {
    func didLoad()
    func didAppear()
    func didDisappear()
    func willAppear()
    func willDisappear()
}

public extension BaseControllerOutput {
    func didLoad() { }
    func didAppear() { }
    func didDisappear() { }
    func willAppear() { }
    func willDisappear() { }
}
