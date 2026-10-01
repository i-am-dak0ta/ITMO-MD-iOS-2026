//
//  ContentView.swift
//  FilmRanking
//
//  Корневой экран: таббар с тремя вкладками.
//

import SwiftUI

struct ContentView: View {
    let dependencies: AppDependencies

    var body: some View {
        TabView {
            SearchView(dependencies: dependencies)
                .tabItem { Label("Поиск", systemImage: "magnifyingglass") }

            ProfileView(dependencies: dependencies)
                .tabItem { Label("Профиль", systemImage: "person.crop.circle") }

            SettingsView()
                .tabItem { Label("Настройки", systemImage: "gearshape") }
        }
    }
}

#Preview {
    ContentView(dependencies: AppDependencies())
}
