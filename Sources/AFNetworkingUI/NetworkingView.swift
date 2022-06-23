//
//  NetworkingErrorView.swift
//  NetworkingAlamofireSolution
//
//  Created by Nikita Omelchenko on 18.06.2021.
//

import UIKit
import SnapKit
import Style

public final class NetworkingMassage {
    public enum StyleType {
        case success
        case failure
    }

    public static func showMassege(viewController: UIViewController, text: String?, style: StyleType) {
        guard
            let navigationController = viewController.navigationController,
            let window = UIApplication.shared.keyWindow
        else { return }

        let statusBarHeight = window.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero
        let defaultDuration = 0.24

        let stack: UIStackView = build {
            $0 <~ Style.Stack.defaultVerticalStack0
            $0.alpha = 0
        }

        let rootView = build {
            $0.backgroundColor = style == .success ? .lightGray : .red
        }

        let textLabel: UILabel = build {
            $0.textColor = .black
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 16)
            $0.text = text
        }

        stack.addArrangedSubview(rootView)
        rootView.addSubview(textLabel)

        navigationController.navigationBar.addSubview(stack)

        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(statusBarHeight )
            make.bottom.right.left.equalToSuperview().inset(24)
        }

        stack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(-statusBarHeight)
            make.bottom.lessThanOrEqualToSuperview().inset(-64)
        }

        UIView.animate(withDuration: defaultDuration, delay: 0, options: .curveEaseInOut) {
            stack.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: defaultDuration, delay: 4, options: .curveEaseInOut) {
                stack.alpha = 0
            } completion: { _ in
                stack.removeFromSuperview()
            }
        }
    }
}

private extension UIApplication {
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first { $0 is UIWindowScene }
            // Get its associated windows
            .flatMap { $0 as? UIWindowScene }?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
}
