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
                Section {
                    LabeledContent("Кинопоиск", value: viewModel.isAccountLinked ? "Привязан" : "Не привязан")
                    if let maskedApiKey = viewModel.maskedApiKey {
                        LabeledContent("API-ключ", value: maskedApiKey)
                    }
                    if viewModel.isAccountLinked {
                        Button("Отвязать", role: .destructive) {
                            viewModel.unlinkAccount()
                        }
                    } else {
                        Button("Привязать API-ключ") {
                            viewModel.linkAccountTapped()
                        }
                    }
                } header: {
                    Text("Аккаунт")
                } footer: {
                    Text("Ключ хранится в Keychain.")
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
            .sheet(isPresented: $viewModel.isLinkSheetPresented) {
                LinkApiKeyView(viewModel: viewModel)
            }
        }
    }
}

/// Экран ввода API-ключа Кинопоиска.
private struct LinkApiKeyView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    SecureField("API-ключ", text: $viewModel.apiKeyInput)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                } footer: {
                    Text("Ключ сохранится в Keychain и будет использоваться для запросов к API Кинопоиска.")
                }
            }
            .navigationTitle("API Кинопоиска")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") { viewModel.saveApiKey() }
                        .disabled(!viewModel.canSaveApiKey)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
