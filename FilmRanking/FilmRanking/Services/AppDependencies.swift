//
//  AppDependencies.swift
//  FilmRanking
//

import Foundation

/// Все зависимости приложения в одном месте.
/// Когда появится сеть  MockMovieService заменится на настоящий сервис.
final class AppDependencies {
    let movieService: MovieServiceProtocol
    let library: UserLibrary

    init(
        movieService: MovieServiceProtocol = MockMovieService(),
        library: UserLibrary = UserLibrary()
    ) {
        self.movieService = movieService
        self.library = library
    }
}
