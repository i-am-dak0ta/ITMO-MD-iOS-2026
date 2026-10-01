//
//  UserLibrary.swift
//  FilmRanking
//

import Combine
import Foundation
import SwiftData

/// Хранилище списков пользователя («Просмотрено», «Хочу посмотреть»).
/// Общее для всех экранов: изменения на экране фильма сразу видны в профиле.
/// Данные лежат в локальной базе и переживают перезапуск приложения.
final class UserLibrary: ObservableObject {
    @Published private(set) var entries: [LibraryEntry] = []

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
        reload()
    }

    func entry(for movieId: Int) -> LibraryEntry? {
        entries.first { $0.movie.id == movieId }
    }

    /// nil — убрать фильм из библиотеки.
    func setStatus(_ status: WatchStatus?, for movie: Movie) {
        let record = entryRecord(movieId: movie.id)

        guard let status else {
            if let record {
                context.delete(record)
            }
            saveAndReload()
            return
        }

        if let record {
            record.statusRaw = status.rawValue
            if status == .watched, record.watchedDate == nil {
                record.watchedDate = Date()
            }
        } else {
            context.insert(
                LibraryEntryRecord(
                    movie: movieRecord(for: movie),
                    status: status,
                    userRating: nil,
                    watchedDate: status == .watched ? Date() : nil
                )
            )
        }

        saveAndReload()
    }

    // MARK: - База

    private func entryRecord(movieId: Int) -> LibraryEntryRecord? {
        var descriptor = FetchDescriptor<LibraryEntryRecord>(
            predicate: #Predicate { $0.movieId == movieId }
        )
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }

    /// Фильм из базы, а если его там нет (например, придёт из API) — сохраняем его.
    private func movieRecord(for movie: Movie) -> MovieRecord {
        let movieId = movie.id
        var descriptor = FetchDescriptor<MovieRecord>(
            predicate: #Predicate { $0.id == movieId }
        )
        descriptor.fetchLimit = 1

        if let existing = try? context.fetch(descriptor).first {
            return existing
        }

        let record = MovieRecord(movie: movie, popularRank: nil)
        context.insert(record)
        return record
    }

    private func saveAndReload() {
        do {
            try context.save()
        } catch {
            assertionFailure("Не удалось сохранить библиотеку: \(error)")
        }
        reload()
    }

    private func reload() {
        do {
            entries = try context
                .fetch(FetchDescriptor<LibraryEntryRecord>())
                .compactMap(LibraryEntry.init(record:))
        } catch {
            assertionFailure("Не удалось прочитать библиотеку из базы: \(error)")
        }
    }
}
