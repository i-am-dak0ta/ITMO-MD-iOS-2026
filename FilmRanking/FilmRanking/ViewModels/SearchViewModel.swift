//
//  SearchViewModel.swift
//  FilmRanking
//

import Combine
import Foundation

final class SearchViewModel: ObservableObject {
    /// Текст в поле поиска. Пока ни на что не влияет.
    @Published var query: String = ""
    @Published private(set) var popularMovies: [Movie] = []

    private let movieService: MovieServiceProtocol

    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
        loadPopular()
    }

    var isSearching: Bool {
        !query.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func loadPopular() {
        popularMovies = movieService.popularMovies()
    }
}
