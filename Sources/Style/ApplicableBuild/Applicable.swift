//
//  Applicable.swift
// AdidasTestProject
//
//  Created by Nikita Omelchenko on 07.05.2022.
//

import UIKit

// MARK: - Applicable
public protocol Applicable {
    associatedtype Applicant

    func apply(_ object: Applicant)
}

precedencegroup StylePrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

infix operator <~: StylePrecedence

@discardableResult
public func <~<T: Applicable>(object: T.Applicant, applicable: T) -> T.Applicant {
    applicable.apply(object)
    return object
}

public func <~ (string: String, attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
    NSAttributedString(string: string, attributes: attributes)
}

@discardableResult
public func <~ (string: NSMutableAttributedString, attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
    string.addAttributes(attributes, range: NSRange(location: .zero, length: string.length))

    return string
}

public func <~ (attributesTo: [NSAttributedString.Key: Any], attributesFrom: [NSAttributedString.Key: Any]) -> [NSAttributedString.Key: Any] {
    var resultsAttributes = attributesTo
    attributesFrom.forEach { item in
        resultsAttributes[item.key] = item.value
    }

    return resultsAttributes
}
