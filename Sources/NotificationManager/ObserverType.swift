//
//  ObserverType.swift
//  JoinLearners
//
//  Created by Vyacheslav on 13.03.2023.
//

import UIKit

// MARK: - NotificationClosure
public typealias NotificationClosure = ((Notification) -> Void)

// MARK: - ObserverType
public struct ObserverType {
    // MARK: - Public Properties
    public let notificationName: NSNotification.Name

    // MARK: - Init
    public init(notificationName: NSNotification.Name) {
        self.notificationName = notificationName
    }
}

// MARK: - Observer Types
public extension ObserverType {
    static let didBecomeActiveNotification: ObserverType = .init(notificationName: UIApplication.didBecomeActiveNotification)
    static let willResignActiveNotification: ObserverType = .init(notificationName: UIApplication.willResignActiveNotification)
    static let keyboardWillHideNotification: ObserverType = .init(notificationName: UIApplication.keyboardWillHideNotification)
    static let keyboardWillShowNotification: ObserverType = .init(notificationName: UIApplication.keyboardWillShowNotification)
}
