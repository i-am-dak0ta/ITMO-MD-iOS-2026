//
//  FilmRankingApp.swift
//  FilmRanking
//
//  Created by Платонова Александра on 24.09.2026.
//

import SwiftUI

@main
struct FilmRankingApp: App {
    private let dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            ContentView(dependencies: dependencies)
        }
    }
}
