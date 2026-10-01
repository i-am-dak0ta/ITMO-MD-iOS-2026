//
//  AppDependencies.swift
//  FilmRanking
//

import Foundation
import SwiftData

/// Все зависимости приложения в одном месте.
/// Когда появится сеть, DatabaseMovieService заменится на настоящий сервис.
final class AppDependencies {
    let movieService: MovieServiceProtocol
    let library: UserLibrary

    private let container: ModelContainer

    /// inMemory: true — база только в памяти, ничего не пишется на диск (для превью).
    init(inMemory: Bool = false) {
        do {
            let container = try ModelContainer(
                for: MovieRecord.self, LibraryEntryRecord.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory)
            )
            let context = ModelContext(container)
            try DatabaseSeeder.seedIfNeeded(context)

            self.container = container
            self.movieService = DatabaseMovieService(context: context)
            self.library = UserLibrary(context: context)
        } catch {
            fatalError("Не удалось подготовить базу данных: \(error)")
        }
    }

    static let preview = AppDependencies(inMemory: true)
}
