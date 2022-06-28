//
//  StoreManager.swift
//  NetworkingAlamofireSolution
//
//  Created by Nikita Omelchenko on 19.10.2021.
//

import Foundation
import KeychainAccess

public protocol StoreProtocol: AnyObject {
    func get<T: Decodable>(_ key: String) -> T?
    func set<T: Encodable>(_ value: T?, key: String)
    func remove(key: String)
    func clear()
}

public final class KeychainStore: StoreProtocol {
    private let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "")

    public func get<T>(_ key: String) -> T? where T: Decodable {
        do {
            guard let data = try keychain.getData(key) else { return nil }

            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            debugPrint("‼️ Error get value 🔑: \(error.localizedDescription)")
            return nil
        }
    }

    public func set<T>(_ value: T?, key: String) where T: Encodable {
        guard let value = value else { return }

        do {
            let data = try JSONEncoder().encode(value)

            try keychain.set(data, key: key)
        } catch let error {
            debugPrint("‼️ Error set to 🔑: \(error.localizedDescription)")
        }
    }

    public func remove(key: String) {
        do {
            try keychain.remove(key)
        } catch let error {
            debugPrint("‼️ Error remove from 🔑: \(error.localizedDescription)")
        }
    }

    public func clear() {
        do {
            try keychain.removeAll()
        } catch let error {
            debugPrint("‼️ Error remove all 🔑: \(error.localizedDescription)")
        }
    }
}

public final class UserDefaultsStore: StoreProtocol {
    private let userDefaults = UserDefaults.standard

    public func get<T>(_ key: String) -> T? where T: Decodable {
        do {
            guard let data = userDefaults.object(forKey: key) as? Data else { return nil }

            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }

    public func set<T>(_ value: T?, key: String) where T: Encodable {
        guard let value = value else { return }

        do {
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: key)
        } catch let error {
            debugPrint("‼️ Error set to 👮🏻‍♂️: \(error.localizedDescription)")
        }
    }

    public func remove(key: String) {
        userDefaults.removeObject(forKey: key)
    }

    public func clear() {
        userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier ?? "")
        userDefaults.synchronize()
    }
}
