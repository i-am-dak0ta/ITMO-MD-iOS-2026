//
//  SettingsViewModel.swift
//  FilmRanking
//

import Combine
import Foundation

/// Переключатели сохраняются в UserDefaults и переживают перезапуск приложения.
/// Тёмная тема применяется сразу (см. ContentView), остальные пока только запоминаются.
/// API-ключ Кинопоиска хранится в Keychain.
final class SettingsViewModel: ObservableObject {
    @Published var isDarkThemeEnabled: Bool {
        didSet { defaults.set(isDarkThemeEnabled, forKey: Keys.isDarkThemeEnabled) }
    }
    @Published var notifyAboutReleases: Bool {
        didSet { defaults.set(notifyAboutReleases, forKey: Keys.notifyAboutReleases) }
    }
    @Published var hideWatchedInRecommendations: Bool {
        didSet { defaults.set(hideWatchedInRecommendations, forKey: Keys.hideWatchedInRecommendations) }
    }

    // MARK: - Аккаунт (Keychain)

    @Published private(set) var isAccountLinked = false
    @Published private(set) var maskedApiKey: String? = nil
    @Published var isLinkSheetPresented = false
    @Published var apiKeyInput = ""

    private let defaults: UserDefaults
    private let keychain: KeychainService

    init(defaults: UserDefaults = .standard, keychain: KeychainService = KeychainService()) {
        self.defaults = defaults
        self.keychain = keychain

        defaults.register(defaults: [
            Keys.isDarkThemeEnabled: false,
            Keys.notifyAboutReleases: true,
            Keys.hideWatchedInRecommendations: false
        ])

        isDarkThemeEnabled = defaults.bool(forKey: Keys.isDarkThemeEnabled)
        notifyAboutReleases = defaults.bool(forKey: Keys.notifyAboutReleases)
        hideWatchedInRecommendations = defaults.bool(forKey: Keys.hideWatchedInRecommendations)

        refreshAccount()
    }

    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—"
    }

    var canSaveApiKey: Bool {
        !apiKeyInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func linkAccountTapped() {
        apiKeyInput = ""
        isLinkSheetPresented = true
    }

    func saveApiKey() {
        let key = apiKeyInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !key.isEmpty, keychain.save(key, for: KeychainService.Key.kinopoiskToken) else { return }
        apiKeyInput = ""
        isLinkSheetPresented = false
        refreshAccount()
    }

    func unlinkAccount() {
        keychain.delete(KeychainService.Key.kinopoiskToken)
        refreshAccount()
    }

    private func refreshAccount() {
        let key = keychain.read(KeychainService.Key.kinopoiskToken)
        isAccountLinked = key != nil
        maskedApiKey = key.map { "••••" + String($0.suffix(4)) }
    }

    /// Не private: ключ темы читает ContentView через @AppStorage.
    enum Keys {
        static let isDarkThemeEnabled = "settings.isDarkThemeEnabled"
        static let notifyAboutReleases = "settings.notifyAboutReleases"
        static let hideWatchedInRecommendations = "settings.hideWatchedInRecommendations"
    }
}
