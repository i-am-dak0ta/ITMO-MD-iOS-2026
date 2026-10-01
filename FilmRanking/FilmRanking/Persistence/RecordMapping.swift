//
//  RecordMapping.swift
//  FilmRanking
//
//  Перевод записей базы в модели, с которыми работают экраны.
//

import Foundation

extension Movie {
    init(record: MovieRecord) {
        self.init(
            id: record.id,
            title: record.title,
            originalTitle: record.originalTitle,
            year: record.year,
            releaseDate: record.releaseDate,
            description: record.overview,
            countries: record.countries,
            genres: record.genres,
            actors: record.actors,
            durationMinutes: record.durationMinutes,
            kinopoiskRating: record.kinopoiskRating,
            imdbRating: record.imdbRating,
            posterURL: record.posterURLString.flatMap(URL.init(string:))
        )
    }
}

extension LibraryEntry {
    /// nil, если у записи нет фильма или статус не распознан.
    init?(record: LibraryEntryRecord) {
        guard
            let movieRecord = record.movie,
            let status = WatchStatus(rawValue: record.statusRaw)
        else {
            return nil
        }

        self.init(
            movie: Movie(record: movieRecord),
            status: status,
            userRating: record.userRating,
            watchedDate: record.watchedDate
        )
    }
}
