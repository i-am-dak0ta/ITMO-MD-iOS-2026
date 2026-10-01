//
//  MovieService.swift
//  FilmRanking
//

import Foundation
import SwiftData

/// Источник данных о фильмах. Сейчас — локальная база, потом сюда встанет клиент API Кинопоиска.
protocol MovieServiceProtocol {
    func popularMovies() -> [Movie]
    func searchMovies(query: String) -> [Movie]
    func movie(id: Int) -> Movie?
}

struct DatabaseMovieService: MovieServiceProtocol {
    let context: ModelContext

    func popularMovies() -> [Movie] {
        let descriptor = FetchDescriptor<MovieRecord>(
            predicate: #Predicate { $0.popularRank != nil }
        )

        return fetch(descriptor)
            .sorted { ($0.popularRank ?? 0) < ($1.popularRank ?? 0) }
            .map(Movie.init(record:))
    }

    func searchMovies(query: String) -> [Movie] {
        // TODO: заменить на запрос к API. Сейчас экран поиска это не вызывает.
        []
    }

    func movie(id: Int) -> Movie? {
        let movieId = id
        var descriptor = FetchDescriptor<MovieRecord>(
            predicate: #Predicate { $0.id == movieId }
        )
        descriptor.fetchLimit = 1

        return fetch(descriptor).first.map(Movie.init(record:))
    }

    private func fetch(_ descriptor: FetchDescriptor<MovieRecord>) -> [MovieRecord] {
        do {
            return try context.fetch(descriptor)
        } catch {
            assertionFailure("Не удалось прочитать фильмы из базы: \(error)")
            return []
        }
    }
}
