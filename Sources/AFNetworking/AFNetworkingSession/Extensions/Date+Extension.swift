//
//  Date+Extension.swift
// AdidasTestProject
//
//  Created by Nikita Omelchenko on 08.05.2022.
//

import Foundation

extension Date {
    static func - (lhs: Date, rhs: Date) -> Date {
        .init(timeIntervalSinceReferenceDate: lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate)
    }
}
