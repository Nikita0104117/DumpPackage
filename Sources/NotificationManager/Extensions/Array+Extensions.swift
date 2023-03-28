//
//  Array+Extensions.swift
//  Parus-iOS
//
//  Created by Vyacheslav on 27.03.2023.
//

import Foundation

extension Array where Element == NotificationCenterManager.NotificationTask {
    mutating func removeTasks() {
        self.forEach { $0.cancel() }
        self.removeAll()
    }
}
