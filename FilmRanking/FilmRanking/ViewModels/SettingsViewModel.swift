//
//  SettingsViewModel.swift
//  FilmRanking
//

import Combine
import Foundation

/// Настройки пока ничего не делают — только хранят состояние переключателей.
/// Переключатели сохраняются в UserDefaults и переживают перезапуск приложения.
final class SettingsViewModel: ObservableObject {
    @Published var isAccountLinked = false
    @Published var isDarkThemeEnabled: Bool {
        didSet { defaults.set(isDarkThemeEnabled, forKey: Keys.isDarkThemeEnabled) }
    }
    @Published var notifyAboutReleases: Bool {
        didSet { defaults.set(notifyAboutReleases, forKey: Keys.notifyAboutReleases) }
    }
    @Published var hideWatchedInRecommendations: Bool {
        didSet { defaults.set(hideWatchedInRecommendations, forKey: Keys.hideWatchedInRecommendations) }
    }
    @Published var showNotAvailableAlert = false

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        defaults.register(defaults: [
            Keys.isDarkThemeEnabled: false,
            Keys.notifyAboutReleases: true,
            Keys.hideWatchedInRecommendations: false
        ])

        isDarkThemeEnabled = defaults.bool(forKey: Keys.isDarkThemeEnabled)
        notifyAboutReleases = defaults.bool(forKey: Keys.notifyAboutReleases)
        hideWatchedInRecommendations = defaults.bool(forKey: Keys.hideWatchedInRecommendations)
    }

    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—"
    }

    func linkAccountTapped() {
        // TODO: авторизация в Кинопоиске
        showNotAvailableAlert = true
    }

    private enum Keys {
        static let isDarkThemeEnabled = "settings.isDarkThemeEnabled"
        static let notifyAboutReleases = "settings.notifyAboutReleases"
        static let hideWatchedInRecommendations = "settings.hideWatchedInRecommendations"
    }
}
