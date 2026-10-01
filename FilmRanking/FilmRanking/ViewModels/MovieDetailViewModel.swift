//
//  MovieDetailViewModel.swift
//  FilmRanking
//

import Combine
import Foundation

final class MovieDetailViewModel: ObservableObject {
    let movie: Movie
    @Published private(set) var entry: LibraryEntry? = nil

    private let library: UserLibrary

    init(movie: Movie, library: UserLibrary) {
        self.movie = movie
        self.library = library
        let movieId = movie.id
        library.$entries
            .map { entries in entries.first { $0.movie.id == movieId } }
            .assign(to: &$entry)
    }

    // MARK: - Состояние кнопок

    var isWantToWatch: Bool { entry?.status == .wantToWatch }
    var isWatched: Bool { entry?.status == .watched }

    func toggleWantToWatch() {
        library.setStatus(isWantToWatch ? nil : .wantToWatch, for: movie)
    }

    func toggleWatched() {
        library.setStatus(isWatched ? nil : .watched, for: movie)
    }

    // MARK: - Данные для отображения

    var subtitle: String {
        var parts = [String(movie.year)]
        if let minutes = movie.durationMinutes {
            parts.append("\(minutes / 60) ч \(minutes % 60) мин")
        }
        return parts.joined(separator: " · ")
    }

    var kinopoiskRatingText: String? {
        movie.kinopoiskRating.map { String(format: "%.1f", $0) }
    }

    var imdbRatingText: String? {
        movie.imdbRating.map { String(format: "%.1f", $0) }
    }

    var userRatingText: String? {
        entry?.userRating.map { "\($0)/10" }
    }

    var releaseDateText: String {
        guard let date = movie.releaseDate else { return "—" }
        return date.formatted(.dateTime.day().month(.wide).year().locale(Locale(identifier: "ru_RU")))
    }

    var countriesText: String { movie.countries.joined(separator: ", ") }
    var genresText: String { movie.genres.joined(separator: ", ") }
    var actorsText: String { movie.actors.joined(separator: ", ") }
}
