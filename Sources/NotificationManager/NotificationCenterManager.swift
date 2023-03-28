//
//  NewNotificationCenterManager.swift
//  JoinLearners
//
//  Created by Vyacheslav on 14.03.2023.
//

import Foundation

// MARK: - NotificationCenterManager
public final class NotificationCenterManager: NotificationCenterProtocol {
    typealias NotificationTask = Task<(), Error>

    // MARK: - ConcreteBag
    struct ConcreteBag: Identifiable {
        var id: ObjectIdentifier
        var data: [NotificationData]
        var tasks: [NotificationTask]
        var object: AnyObject?

        // MARK: - NotificationData
        struct NotificationData {
            var type: ObserverType
            var action: NotificationClosure?
        }
    }

    // MARK: - Dependencies
    private let center: NotificationCenter = .default

    // MARK: - DataSource
    private var dataSource: [ConcreteBag] = []

    // MARK: - Public Methods
    public func registerObservers(target: Target, types observerTypes: [ObserverType], object: AnyObject?) {
        let notificationData: [ConcreteBag.NotificationData] = observerTypes.map { .init(type: $0) }
        let bag: ConcreteBag = .init(
            id: .init(target),
            data: notificationData,
            tasks: [],
            object: object
        )
        dataSource.append(bag)
    }

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
    public func processObservers(
        for target: Target,
        _ closure: ((ObserverType) -> NotificationClosure?)
    ) {
        // find bag index for current target
        guard let bagIndex = dataSource.firstIndex(where: { $0.id == .init(target) }) else { return }

        // update notificationData
        let notificationData = dataSource[bagIndex].data
        let updatedData: [ConcreteBag.NotificationData] = notificationData.map {
            let action = closure($0.type)
            return .init(type: $0.type, action: action)
        }

        dataSource[bagIndex].data = updatedData

        dataSource[bagIndex].data.forEach {
            addObserver(target: target, data: $0, object: dataSource[bagIndex].object)
        }
    }

    public func post(for type: ObserverType, object: Any?, userInfo: [AnyHashable: Any]?) {
        center.post(name: type.notificationName, object: object, userInfo: userInfo)
    }

    public func removeObservers(for target: Target) {
        guard let bagIndex = dataSource.firstIndex(where: { $0.id == .init(target) }) else { return }

        dataSource[bagIndex].tasks.removeTasks()
        dataSource.remove(at: bagIndex)
    }

    public func removeAllObservers() {
        dataSource.forEach { _ in removeFirstTargetObservers() }
    }
}

// MARK: - Private Methods
private extension NotificationCenterManager {
    func addObserver(target: Target, data: ConcreteBag.NotificationData, object: AnyObject?) {
        guard let action = data.action else {
            debugPrint("😢 Failed to register notification: \(data.type), action: \(data.action.debugDescription)")
            return
        }

        // call closures in main thread
        let subscription: NotificationTask = Task { @MainActor @Sendable [weak self] in
            guard let self = self else { return }

            for await notification in self.center.notifications(named: data.type.notificationName, object: object) {
                action(notification)
            }
        }
        // check is tasks array exist for current target
        if let bagIndex = dataSource.firstIndex(where: { $0.id == .init(target) }) {
            dataSource[bagIndex].tasks.append(subscription)
        }
    }

    func removeFirstTargetObservers() {
        var bag = dataSource.removeFirst()
        bag.tasks.removeTasks()
    }
}
