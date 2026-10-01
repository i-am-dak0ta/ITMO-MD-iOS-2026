//
//  ProfileViewModel.swift
//  FilmRanking
//

import Combine
import Foundation

final class ProfileViewModel: ObservableObject {
    let userName = "Пользователь"

    @Published var selectedStatus: WatchStatus = .watched {
        didSet {
            // Для «Хочу посмотреть» нет моей оценки и даты просмотра
            if !availableSorts.contains(sort) {
                sort = availableSorts.first ?? .releaseDate
            }
        }
    }
    @Published var sort: LibrarySort = .watchedDate

    @Published private var allEntries: [LibraryEntry] = []

    init(library: UserLibrary) {
        // Подписка на хранилище: профиль обновляется, когда фильм добавили/убрали на другом экране
        library.$entries.assign(to: &$allEntries)
    }

    var availableSorts: [LibrarySort] {
        switch selectedStatus {
        case .watched: return LibrarySort.allCases
        case .wantToWatch: return [.kinopoiskRating, .releaseDate]
        }
    }

    var watchedCount: Int { allEntries.filter { $0.status == .watched }.count }
    var wantToWatchCount: Int { allEntries.filter { $0.status == .wantToWatch }.count }

    var visibleEntries: [LibraryEntry] {
        allEntries
            .filter { $0.status == selectedStatus }
            .sorted { lhs, rhs in
                switch sort {
                case .userRating:
                    return Self.descending(lhs.userRating, rhs.userRating)
                case .kinopoiskRating:
                    return Self.descending(lhs.movie.kinopoiskRating, rhs.movie.kinopoiskRating)
                case .releaseDate:
                    return Self.descending(lhs.movie.releaseDate, rhs.movie.releaseDate)
                case .watchedDate:
                    return Self.descending(lhs.watchedDate, rhs.watchedDate)
                }
            }
    }

    /// Сортировка по убыванию, пустые значения в конец.
    private static func descending<T: Comparable>(_ lhs: T?, _ rhs: T?) -> Bool {
        switch (lhs, rhs) {
        case let (l?, r?): return l > r
        case (.some, .none): return true
        default: return false
        }
    }
}
