//
//  SettingsViewModel.swift
//  FilmRanking
//

import Combine
import Foundation

/// Настройки пока ничего не делают  только хранят состояние переключателей.
final class SettingsViewModel: ObservableObject {
    @Published var isAccountLinked = false
    @Published var isDarkThemeEnabled = false
    @Published var notifyAboutReleases = true
    @Published var hideWatchedInRecommendations = false
    @Published var showNotAvailableAlert = false

    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—"
    }

    func linkAccountTapped() {
        // TODO: авторизация в Кинопоиске
        showNotAvailableAlert = true
    }
}
