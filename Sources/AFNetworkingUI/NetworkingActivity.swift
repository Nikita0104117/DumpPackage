//
//  NetworkingActivity.swift
//  NetworkingAlamofireSolution
//
//  Created by Nikita Omelchenko on 22.06.2021.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Style

public final class NetworkingActivity {
    private static var zeroViewController: UIViewController = .init()

    private static let activity: NVActivityIndicatorView = .init(frame: .zero)
    private static let zeroView: UIView = build {
        $0.backgroundColor = .black
        $0.alpha = 0.2
    }

    private static var isPresented: Bool = false

    public static func show(viewController: UIViewController, color: UIColor, type: NVActivityIndicatorType) {
        guard
            let navigationController = viewController.navigationController,
            isPresented == false
        else { return }

        activity.color = color
        activity.type = type

        zeroViewController.modalPresentationStyle = .overFullScreen
        zeroViewController.view.addSubview(zeroView)
        zeroViewController.view.addSubview(activity)

        zeroView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }

        activity.snp.makeConstraints { make in
            make.width.height.equalTo(zeroViewController.view.frame.width * 0.2)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        activity.startAnimating()

        navigationController.present(zeroViewController, animated: false) { [weak self] in self?.isPresented = true }

    }

    public static func hide() {
        guard isPresented else { return }

        activity.stopAnimating()
        zeroViewController.dismiss(animated: false) {
            isPresented = false
            zeroViewController = .init()
        }
    }
}
