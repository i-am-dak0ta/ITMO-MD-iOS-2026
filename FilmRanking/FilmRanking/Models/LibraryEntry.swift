//
//  LibraryEntry.swift
//  FilmRanking
//

import Foundation

/// Статус фильма в библиотеке пользователя.
enum WatchStatus: String, CaseIterable, Identifiable {
    case watched
    case wantToWatch

    var id: Self { self }

    var title: String {
        switch self {
        case .watched: return "Просмотрено"
        case .wantToWatch: return "Хочу посмотреть"
        }
    }
}

/// Фильм в библиотеке пользователя + его личные данные о нём.
struct LibraryEntry: Identifiable, Hashable {
    let movie: Movie
    var status: WatchStatus
    var userRating: Int?         // 1...10
    var watchedDate: Date?

    var id: Int { movie.id }
}

/// Варианты сортировки списков в профиле.
enum LibrarySort: String, CaseIterable, Identifiable {
    case userRating
    case kinopoiskRating
    case releaseDate
    case watchedDate

    var id: Self { self }

    var title: String {
        switch self {
        case .userRating: return "Моя оценка"
        case .kinopoiskRating: return "Рейтинг КП"
        case .releaseDate: return "Дата выхода"
        case .watchedDate: return "Дата просмотра"
        }
    }
}
