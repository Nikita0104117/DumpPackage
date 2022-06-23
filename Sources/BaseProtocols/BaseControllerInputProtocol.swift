//
//  BaseControllerInputProtocol.swift
//
//
//  Created by Nikita Omelchenko
//

import UIKit
import AFNetworkingUITarget

protocol BaseControllerInput: AnyObject {
    func showNetworking(error text: String?)
    func showNetworking(info text: String?)
    func showActivity()
    func hideActivity()
    func showActivity(delay: CGFloat)
}

extension BaseControllerInput where Self: UIViewController {
//    func showNetworking(error text: String?) {
//        NetworkingMassage.showMassege(viewController: self, text: text, style: .failure)
//    }
//
//    func showNetworking(info text: String?) {
//        NetworkingMassage.showMassege(viewController: self, text: text, style: .success)
//    }
//
//    func showActivity(delay: CGFloat) {
//        showActivity()
//        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//            self.hideActivity()
//        }
//    }
//
//    func showActivity() {
//        DispatchQueue.main.async {
//            NetworkingActivity.show(viewController: self, color: AppColors.blue.color, type: .circleStrokeSpin)
//        }
//    }
//
//    func hideActivity() {
//        DispatchQueue.main.async {
//            NetworkingActivity.hide()
//        }
//    }
}
