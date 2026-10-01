//
//  SettingsView.swift
//  FilmRanking
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationStack {
            Form {
                Section("Аккаунт") {
                    LabeledContent("Кинопоиск", value: viewModel.isAccountLinked ? "Привязан" : "Не привязан")
                    Button("Привязать аккаунт") {
                        viewModel.linkAccountTapped()
                    }
                }

                Section("Оформление") {
                    Toggle("Тёмная тема", isOn: $viewModel.isDarkThemeEnabled)
                }

                Section("Уведомления") {
                    Toggle("Выход фильмов из «Хочу посмотреть»", isOn: $viewModel.notifyAboutReleases)
                }

                Section("Рекомендации") {
                    Toggle("Скрывать просмотренные", isOn: $viewModel.hideWatchedInRecommendations)
                }

                Section("О приложении") {
                    LabeledContent("Версия", value: viewModel.appVersion)
                }
            }
            .navigationTitle("Настройки")
            .alert("Пока недоступно", isPresented: $viewModel.showNotAvailableAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Привязка аккаунта появится после подключения API Кинопоиска.")
            }
        }
    }
}

#Preview {
    SettingsView()
}
