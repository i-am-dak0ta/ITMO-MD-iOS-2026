//
//  ProfileView.swift
//  FilmRanking
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    private let dependencies: AppDependencies

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
        _viewModel = StateObject(wrappedValue: ProfileViewModel(library: dependencies.library))
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    header
                }

                Section {
                    Picker("Список", selection: $viewModel.selectedStatus) {
                        ForEach(WatchStatus.allCases) { status in
                            Text(status.title).tag(status)
                        }
                    }
                    .pickerStyle(.segmented)

                    Picker("Сортировка", selection: $viewModel.sort) {
                        ForEach(viewModel.availableSorts) { sort in
                            Text(sort.title).tag(sort)
                        }
                    }
                }

                Section {
                    if viewModel.visibleEntries.isEmpty {
                        Text("Здесь пока пусто")
                            .foregroundStyle(.secondary)
                    }
                    ForEach(viewModel.visibleEntries) { entry in
                        NavigationLink(value: entry.movie) {
                            MovieRowView(movie: entry.movie, entry: entry)
                        }
                    }
                }
            }
            .navigationTitle("Профиль")
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie, library: dependencies.library)
            }
        }
    }

    private var header: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundStyle(.gray)

            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.userName)
                    .font(.title3.bold())
                Text("Просмотрено: \(viewModel.watchedCount)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("Хочу посмотреть: \(viewModel.wantToWatchCount)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ProfileView(dependencies: AppDependencies())
}
