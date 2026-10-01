//
//  PosterView.swift
//  FilmRanking
//

import SwiftUI

/// Заглушка постера, пока нет загрузки картинок из сети.
struct PosterView: View {
    let movie: Movie

    private static let palette: [Color] = [.indigo, .orange, .teal, .pink, .purple, .blue, .green, .red]

    var body: some View {
        let color = Self.palette[abs(movie.id) % Self.palette.count]
        RoundedRectangle(cornerRadius: 8)
            .fill(color.gradient)
            .overlay {
                Image(systemName: "film")
                    .font(.title2)
                    .foregroundStyle(.white.opacity(0.85))
            }
            .aspectRatio(2.0 / 3.0, contentMode: .fit)
    }
}

#Preview {
    Group {
        if let movie = AppDependencies.preview.movieService.popularMovies().first {
            PosterView(movie: movie)
                .frame(width: 120)
        }
    }
}
