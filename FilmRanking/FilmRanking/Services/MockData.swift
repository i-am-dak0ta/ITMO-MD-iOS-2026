//
//  MockData.swift
//  FilmRanking
//
//  Тестовые данные до подключения API
//

import Foundation

enum MockData {
    static let movies: [Movie] = [
        Movie(
            id: 1,
            title: "Побег из Шоушенка",
            originalTitle: "The Shawshank Redemption",
            year: 1994,
            releaseDate: date(1994, 9, 23),
            description: "Банкира Энди Дюфрейна обвиняют в убийстве и отправляют в тюрьму Шоушенк. За долгие годы заключения он находит друзей, сохраняет достоинство и не теряет надежды.",
            countries: ["США"],
            genres: ["драма"],
            actors: ["Тим Роббинс", "Морган Фриман", "Боб Гантон"],
            durationMinutes: 142,
            kinopoiskRating: 9.1,
            imdbRating: 9.3,
            posterURL: nil
        ),
        Movie(
            id: 2,
            title: "Зелёная миля",
            originalTitle: "The Green Mile",
            year: 1999,
            releaseDate: date(1999, 12, 10),
            description: "Надзиратель блока смертников Пол Эджкомб знакомится с новым заключённым — огромным и тихим Джоном Коффи, у которого обнаруживается необычный дар.",
            countries: ["США"],
            genres: ["драма", "фэнтези", "криминал"],
            actors: ["Том Хэнкс", "Майкл Кларк Дункан", "Дэвид Морс"],
            durationMinutes: 189,
            kinopoiskRating: 9.1,
            imdbRating: 8.6,
            posterURL: nil
        ),
        Movie(
            id: 3,
            title: "Интерстеллар",
            originalTitle: "Interstellar",
            year: 2014,
            releaseDate: date(2014, 11, 6),
            description: "Земля умирает, и группа исследователей отправляется через червоточину искать новый дом для человечества.",
            countries: ["США", "Великобритания", "Канада"],
            genres: ["фантастика", "драма", "приключения"],
            actors: ["Мэттью Макконахи", "Энн Хэтэуэй", "Джессика Честейн"],
            durationMinutes: 169,
            kinopoiskRating: 8.6,
            imdbRating: 8.7,
            posterURL: nil
        ),
        Movie(
            id: 4,
            title: "Начало",
            originalTitle: "Inception",
            year: 2010,
            releaseDate: date(2010, 7, 22),
            description: "Кобб умеет проникать в чужие сны и красть идеи. Теперь ему предлагают обратное — внедрить идею в сознание человека.",
            countries: ["США", "Великобритания"],
            genres: ["фантастика", "боевик", "триллер"],
            actors: ["Леонардо ДиКаприо", "Джозеф Гордон-Левитт", "Эллиот Пейдж"],
            durationMinutes: 148,
            kinopoiskRating: 8.7,
            imdbRating: 8.8,
            posterURL: nil
        ),
        Movie(
            id: 5,
            title: "Матрица",
            originalTitle: "The Matrix",
            year: 1999,
            releaseDate: date(1999, 3, 31),
            description: "Хакер Нео узнаёт, что привычный мир — симуляция, и присоединяется к людям, которые с ней борются.",
            countries: ["США"],
            genres: ["фантастика", "боевик"],
            actors: ["Киану Ривз", "Лоренс Фишбёрн", "Кэрри-Энн Мосс"],
            durationMinutes: 136,
            kinopoiskRating: 8.5,
            imdbRating: 8.7,
            posterURL: nil
        ),
        Movie(
            id: 6,
            title: "Брат",
            originalTitle: nil,
            year: 1997,
            releaseDate: date(1997, 12, 12),
            description: "Демобилизованный Данила Багров приезжает в Петербург к старшему брату и оказывается втянут в криминальные разборки.",
            countries: ["Россия"],
            genres: ["драма", "криминал", "боевик"],
            actors: ["Сергей Бодров мл.", "Виктор Сухоруков", "Светлана Письмиченко"],
            durationMinutes: 100,
            kinopoiskRating: 8.3,
            imdbRating: 7.8,
            posterURL: nil
        ),
        Movie(
            id: 7,
            title: "Остров проклятых",
            originalTitle: "Shutter Island",
            year: 2010,
            releaseDate: date(2010, 2, 18),
            description: "Два пристава приезжают на остров с психиатрической клиникой, чтобы найти пропавшую пациентку.",
            countries: ["США"],
            genres: ["триллер", "детектив", "драма"],
            actors: ["Леонардо ДиКаприо", "Марк Руффало", "Бен Кингсли"],
            durationMinutes: 138,
            kinopoiskRating: 8.5,
            imdbRating: 8.2,
            posterURL: nil
        ),
        Movie(
            id: 8,
            title: "Москва слезам не верит",
            originalTitle: nil,
            year: 1979,
            releaseDate: date(1980, 2, 11),
            description: "История трёх подруг, приехавших покорять Москву в конце 1950-х, и их судьбы двадцать лет спустя.",
            countries: ["СССР"],
            genres: ["драма", "мелодрама", "комедия"],
            actors: ["Вера Алентова", "Алексей Баталов", "Ирина Муравьёва"],
            durationMinutes: 150,
            kinopoiskRating: 8.3,
            imdbRating: 8.1,
            posterURL: nil
        )
    ]

    static let libraryEntries: [LibraryEntry] = [
        LibraryEntry(movie: movies[0], status: .watched, userRating: 10, watchedDate: date(2025, 3, 14)),
        LibraryEntry(movie: movies[4], status: .watched, userRating: 9, watchedDate: date(2026, 1, 5)),
        LibraryEntry(movie: movies[5], status: .watched, userRating: 8, watchedDate: date(2024, 11, 20)),
        LibraryEntry(movie: movies[3], status: .watched, userRating: 9, watchedDate: date(2026, 8, 30)),
        LibraryEntry(movie: movies[2], status: .wantToWatch, userRating: nil, watchedDate: nil),
        LibraryEntry(movie: movies[6], status: .wantToWatch, userRating: nil, watchedDate: nil)
    ]

    private static func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
        Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
    }
}
