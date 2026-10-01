//
//  MovieService.swift
//  FilmRanking
//

import Foundation

/// Источник данных о фильмах. Сейчас  моки, потом сюда встанет клиент API Кинопоиска.
protocol MovieServiceProtocol {
    func popularMovies() -> [Movie]
    func searchMovies(query: String) -> [Movie]
    func movie(id: Int) -> Movie?
}

struct MockMovieService: MovieServiceProtocol {
    func popularMovies() -> [Movie] {
        MockData.movies
    }

    func searchMovies(query: String) -> [Movie] {
        // TODO: заменить на запрос к API. Сейчас экран поиска это не вызывает.
        []
    }

    func movie(id: Int) -> Movie? {
        MockData.movies.first { $0.id == id }
    }
}
