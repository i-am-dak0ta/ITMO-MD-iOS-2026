//
//  SearchView.swift
//  FilmRanking
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    private let dependencies: AppDependencies

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
        _viewModel = StateObject(wrappedValue: SearchViewModel(movieService: dependencies.movieService))
    }

    var body: some View {
        NavigationStack {
            List {
                if viewModel.isSearching {
                    Section {
                        Label("Поиск заработает после подключения API Кинопоиска", systemImage: "info.circle")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Популярное") {
                    ForEach(viewModel.popularMovies) { movie in
                        NavigationLink(value: movie) {
                            MovieRowView(movie: movie)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Поиск")
            .searchable(
                text: $viewModel.query,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Фильмы, сериалы, персоны"
            )
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie, library: dependencies.library)
            }
        }
    }
}

#Preview {
    SearchView(dependencies: AppDependencies())
}
