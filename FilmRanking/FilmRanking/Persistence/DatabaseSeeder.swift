//
//  DatabaseSeeder.swift
//  FilmRanking
//
//  Заполняет пустую базу стартовыми данными из SeedData.json.
//

import Foundation
import SwiftData

enum DatabaseSeeder {
    enum SeedError: Error {
        case fileNotFound
    }

    /// Срабатывает только когда в базе ещё нет ни одного фильма — то есть при первом запуске.
    static func seedIfNeeded(_ context: ModelContext) throws {
        guard try context.fetchCount(FetchDescriptor<MovieRecord>()) == 0 else {
            return
        }

        let seed = try loadSeed()

        var moviesById: [Int: MovieRecord] = [:]
        for (index, seedMovie) in seed.movies.enumerated() {
            let record = MovieRecord(movie: seedMovie.movie, popularRank: index)
            context.insert(record)
            moviesById[seedMovie.id] = record
        }

        for seedEntry in seed.library {
            guard
                let movie = moviesById[seedEntry.movieId],
                let status = WatchStatus(rawValue: seedEntry.status)
            else {
                continue
            }

            context.insert(
                LibraryEntryRecord(
                    movie: movie,
                    status: status,
                    userRating: seedEntry.userRating,
                    watchedDate: seedEntry.watchedDate
                )
            )
        }

        try context.save()
    }

    private static func loadSeed() throws -> SeedFile {
        guard let url = Bundle.main.url(forResource: "SeedData", withExtension: "json") else {
            throw SeedError.fileNotFound
        }

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)

        return try decoder.decode(SeedFile.self, from: Data(contentsOf: url))
    }
}

// MARK: - Формат SeedData.json

private struct SeedFile: Decodable {
    let movies: [SeedMovie]
    let library: [SeedLibraryEntry]
}

private struct SeedMovie: Decodable {
    let id: Int
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
    let posterURL: URL?

    var movie: Movie {
        Movie(
            id: id,
            title: title,
            originalTitle: originalTitle,
            year: year,
            releaseDate: releaseDate,
            description: description,
            countries: countries,
            genres: genres,
            actors: actors,
            durationMinutes: durationMinutes,
            kinopoiskRating: kinopoiskRating,
            imdbRating: imdbRating,
            posterURL: posterURL
        )
    }
}

private struct SeedLibraryEntry: Decodable {
    let movieId: Int
    let status: String
    let userRating: Int?
    let watchedDate: Date?
}
