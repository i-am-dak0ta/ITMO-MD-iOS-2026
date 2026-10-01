//
//  MovieRecord.swift
//  FilmRanking
//

import Foundation
import SwiftData

/// Фильм в локальной базе. Экраны работают не с ним, а с `Movie`.
@Model
final class MovieRecord {
    @Attribute(.unique) var id: Int
    var title: String
    var originalTitle: String?
    var year: Int
    var releaseDate: Date?
    var overview: String         // `description` у @Model-класса занято
    var countries: [String]
    var genres: [String]
    var actors: [String]
    var durationMinutes: Int?
    var kinopoiskRating: Double?
    var imdbRating: Double?
    var posterURLString: String?
    var popularRank: Int?        // место в «Популярном», nil — не показывать там

    init(movie: Movie, popularRank: Int?) {
        self.id = movie.id
        self.title = movie.title
        self.originalTitle = movie.originalTitle
        self.year = movie.year
        self.releaseDate = movie.releaseDate
        self.overview = movie.description
        self.countries = movie.countries
        self.genres = movie.genres
        self.actors = movie.actors
        self.durationMinutes = movie.durationMinutes
        self.kinopoiskRating = movie.kinopoiskRating
        self.imdbRating = movie.imdbRating
        self.posterURLString = movie.posterURL?.absoluteString
        self.popularRank = popularRank
    }
}
