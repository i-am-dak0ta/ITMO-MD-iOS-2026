//
//  LibraryEntryRecord.swift
//  FilmRanking
//

import Foundation
import SwiftData

/// Запись библиотеки пользователя в локальной базе. Экраны работают с `LibraryEntry`.
@Model
final class LibraryEntryRecord {
    @Attribute(.unique) var movieId: Int
    var movie: MovieRecord?
    var statusRaw: String        // WatchStatus.rawValue: фильтровать по enum в SwiftData неудобно
    var userRating: Int?         // 1...10
    var watchedDate: Date?

    init(movie: MovieRecord, status: WatchStatus, userRating: Int?, watchedDate: Date?) {
        self.movieId = movie.id
        self.movie = movie
        self.statusRaw = status.rawValue
        self.userRating = userRating
        self.watchedDate = watchedDate
    }
}
