//
//  UserLibrary.swift
//  FilmRanking
//

import Combine
import Foundation

/// Хранилище списков пользователя («Просмотрено», «Хочу посмотреть»).
/// Общее для всех экранов: изменения на экране фильма сразу видны в профиле.
/// Пока живёт только в памяти.
final class UserLibrary: ObservableObject {
    @Published private(set) var entries: [LibraryEntry]

    init(entries: [LibraryEntry] = MockData.libraryEntries) {
        self.entries = entries
    }

    func entry(for movieId: Int) -> LibraryEntry? {
        entries.first { $0.movie.id == movieId }
    }

    /// nil — убрать фильм из библиотеки.
    func setStatus(_ status: WatchStatus?, for movie: Movie) {
        guard let status else {
            entries.removeAll { $0.movie.id == movie.id }
            return
        }

        if let index = entries.firstIndex(where: { $0.movie.id == movie.id }) {
            entries[index].status = status
            if status == .watched, entries[index].watchedDate == nil {
                entries[index].watchedDate = Date()
            }
        } else {
            entries.append(
                LibraryEntry(
                    movie: movie,
                    status: status,
                    userRating: nil,
                    watchedDate: status == .watched ? Date() : nil
                )
            )
        }
    }
}
