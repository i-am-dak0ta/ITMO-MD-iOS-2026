//
//  ContentView.swift
//  FilmRanking
//
//  Корневой экран: таббар с тремя вкладками.
//

import SwiftUI

struct ContentView: View {
    let dependencies: AppDependencies

    /// Читается из UserDefaults и обновляется, когда переключатель меняют в настройках.
    @AppStorage(SettingsViewModel.Keys.isDarkThemeEnabled) private var isDarkThemeEnabled = false

    var body: some View {
        TabView {
            SearchView(dependencies: dependencies)
                .tabItem { Label("Поиск", systemImage: "magnifyingglass") }

            ProfileView(dependencies: dependencies)
                .tabItem { Label("Профиль", systemImage: "person.crop.circle") }

            SettingsView()
                .tabItem { Label("Настройки", systemImage: "gearshape") }
        }
        .preferredColorScheme(isDarkThemeEnabled ? .dark : .light)
    }
}

#Preview {
    ContentView(dependencies: .preview)
}
