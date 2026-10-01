//
//  MovieDetailView.swift
//  FilmRanking
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel: MovieDetailViewModel

    init(movie: Movie, library: UserLibrary) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movie: movie, library: library))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                headerSection
                buttonsSection
                infoSection
                descriptionSection
            }
            .padding()
        }
        .navigationTitle(viewModel.movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Секции

    private var headerSection: some View {
        HStack(alignment: .top, spacing: 16) {
            PosterView(movie: viewModel.movie)
                .frame(width: 120)

            VStack(alignment: .leading, spacing: 6) {
                Text(viewModel.movie.title)
                    .font(.title2.bold())

                if let original = viewModel.movie.originalTitle {
                    Text(original)
                        .foregroundStyle(.secondary)
                }

                Text(viewModel.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                if let kp = viewModel.kinopoiskRatingText {
                    Text("Кинопоиск: \(kp)")
                        .font(.subheadline.bold())
                }
                if let imdb = viewModel.imdbRatingText {
                    Text("IMDb: \(imdb)")
                        .font(.subheadline)
                }
                if let mine = viewModel.userRatingText {
                    Label("Моя оценка: \(mine)", systemImage: "star.fill")
                        .font(.subheadline)
                        .foregroundStyle(.orange)
                }
            }
        }
    }

    private var buttonsSection: some View {
        HStack {
            Button {
                viewModel.toggleWantToWatch()
            } label: {
                Label("Хочу посмотреть", systemImage: viewModel.isWantToWatch ? "bookmark.fill" : "bookmark")
                    .frame(maxWidth: .infinity)
            }
            .tint(viewModel.isWantToWatch ? Color.orange : Color.gray)

            Button {
                viewModel.toggleWatched()
            } label: {
                Label("Смотрел", systemImage: viewModel.isWatched ? "eye.fill" : "eye")
                    .frame(maxWidth: .infinity)
            }
            .tint(viewModel.isWatched ? Color.green : Color.gray)
        }
        .buttonStyle(.bordered)
    }

    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            infoRow(title: "Дата выхода", value: viewModel.releaseDateText)
            infoRow(title: "Страна", value: viewModel.countriesText)
            infoRow(title: "Жанр", value: viewModel.genresText)
            if !viewModel.movie.actors.isEmpty {
                infoRow(title: "В ролях", value: viewModel.actorsText)
            }
        }
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Описание")
                .font(.headline)
            Text(viewModel.movie.description)
        }
    }

    private func infoRow(title: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(title)
                .foregroundStyle(.secondary)
                .frame(width: 110, alignment: .leading)
            Text(value)
        }
        .font(.subheadline)
    }
}

#Preview {
    let dependencies = AppDependencies.preview

    NavigationStack {
        if let movie = dependencies.movieService.movie(id: 3) {
            MovieDetailView(movie: movie, library: dependencies.library)
        }
    }
}
