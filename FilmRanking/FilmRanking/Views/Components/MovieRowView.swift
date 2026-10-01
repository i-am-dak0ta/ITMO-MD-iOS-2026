//
//  MovieRowView.swift
//  FilmRanking
//

import SwiftUI

/// Строка фильма в списке. Если передан entry — показываем личные данные пользователя.
struct MovieRowView: View {
    let movie: Movie
    var entry: LibraryEntry? = nil

    var body: some View {
        HStack(spacing: 12) {
            PosterView(movie: movie)
                .frame(width: 50)

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)

                Text(([String(movie.year)] + movie.genres.prefix(2)).joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                if let entry {
                    HStack(spacing: 8) {
                        if let rating = entry.userRating {
                            Label("\(rating)", systemImage: "star.fill")
                        }
                        if let date = entry.watchedDate {
                            Label(date.formatted(date: .abbreviated, time: .omitted), systemImage: "eye")
                        }
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }

            Spacer()

            if let rating = movie.kinopoiskRating {
                Text(String(format: "%.1f", rating))
                    .font(.subheadline.bold())
                    .foregroundStyle(rating >= 7 ? Color.green : Color.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List {
        MovieRowView(movie: MockData.movies[0])
        MovieRowView(movie: MockData.libraryEntries[0].movie, entry: MockData.libraryEntries[0])
    }
}
