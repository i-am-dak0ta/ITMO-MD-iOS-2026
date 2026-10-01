//
//  KeychainService.swift
//  FilmRanking
//
//  Хранение секретов (токен API Кинопоиска) в Keychain.
//  В отличие от UserDefaults, данные в Keychain зашифрованы системой.
//

import Foundation
import Security

final class KeychainService {
    enum Key {
        static let kinopoiskToken = "kinopoisk.apiToken"
    }

    private let service: String

    init(service: String = Bundle.main.bundleIdentifier ?? "FilmRanking") {
        self.service = service
    }

    @discardableResult
    func save(_ value: String, for key: String) -> Bool {
        let data = Data(value.utf8)
        // Сначала удаляем старое значение, чтобы не получить errSecDuplicateItem
        delete(key)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }

    func read(_ key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        guard SecItemCopyMatching(query as CFDictionary, &result) == errSecSuccess,
              let data = result as? Data else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }

    @discardableResult
    func delete(_ key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
}
