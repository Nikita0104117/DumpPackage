//
//  NotificationCenterManagerProtocols.swift
//  JoinLearners
//
//  Created by Vyacheslav on 14.03.2023.
//

import Foundation

// MARK: - NotificationCenterTarget
public typealias NotificationCenterTarget = AnyObject

// MARK: - NotificationCenterProtocol
public typealias NotificationCenterProtocol = NotificationObservable & NotificationSendable

// MARK: - NotificationObservable
public protocol NotificationObservable: AnyObject {
    typealias Target = NotificationCenterTarget

    func registerObservers(target: Target, types observerTypes: [ObserverType], object: AnyObject?)

    func removeObservers(for target: Target)
    func removeAllObservers()
}

public extension NotificationObservable {
    func registerObservers(target: Target, types observerTypes: ObserverType..., object: AnyObject? = nil) {
        registerObservers(target: target, types: observerTypes, object: object)
    }

    func registerObservers(target: Target, types observerTypes: [ObserverType], object: AnyObject? = nil) {
        registerObservers(target: target, types: observerTypes, object: object)
    }
}

// MARK: - NotificationSendable
public protocol NotificationSendable: AnyObject {
    typealias Target = NotificationCenterTarget

    /// Use this method to process observers by their type.
    ///
    /// Use `if case` if you need to observe equal or less than 3 observers:
    ///
    ///     @Injected(.lazily) var notificationSendable: NotificationCenterProtocol
    ///     notificationSendable.processObservers(for: notificationsOutput) { [weak self] observerType in
    ///         if case .keyboardWillHideNotification = observerType {
    ///             return self?.keyboardWillHideClosure
    ///         }
    ///         if case .keyboardWillShowNotification = observerType {
    ///             return self?.keyboardWillShowClosure
    ///         }
    ///         return nil
    ///     }
    ///
    /// In other ways use `switch case` for processing:
    ///
    ///     @Injected(.lazily) var notificationSendable: NotificationCenterProtocol
    ///     notificationSendable.processObservers(for: notificationsOutput) { [weak self] observerType in
    ///         switch observerType {
    ///             case .keyboardWillHideNotification:
    ///                 return self?.keyboardWillHideClosure
    ///             case .keyboardWillShowNotification:
    ///                 return self?.keyboardWillShowClosure
    ///             default:
    ///                 return nil
    ///             }
    ///     }
    ///
    /// - Parameters:
    ///   - target: object who registered on notification
    ///   - closure: closure for processing observer event.
    func processObservers(for target: Target, _ closure: ((ObserverType) -> NotificationClosure?))

    func post(for type: ObserverType, object: Any?, userInfo: [AnyHashable: Any]?)
}

public extension NotificationSendable {
    func post(for type: ObserverType, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        post(for: type, object: object, userInfo: userInfo)
    }
}
