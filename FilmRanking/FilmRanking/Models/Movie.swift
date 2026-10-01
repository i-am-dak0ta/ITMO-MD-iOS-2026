//
//  Movie.swift
//  FilmRanking
//

import Foundation

/// Модель фильма. Поля подобраны под то, что потом придёт из API Кинопоиска.
struct Movie: Identifiable, Hashable {
    let id: Int                  // в будущем — kinopoiskId
    let title: String
    let originalTitle: String?
    let year: Int
    let releaseDate: Date?
    let description: String
    let countries: [String]
    let genres: [String]
    let actors: [String]
    let durationMinutes: Int?
    let kinopoiskRating: Double?
    let imdbRating: Double?
    let posterURL: URL?          // пока nil — показываем заглушку
}
