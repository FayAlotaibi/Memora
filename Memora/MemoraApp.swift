//
//  MemoraApp.swift
//  Memora
//

import SwiftUI
import SwiftData

@main
struct MemoraApp: App {

    var body: some Scene {

        WindowGroup {

            NavigationStack {

                SwiftUIView()
            }
        }
        .modelContainer(
            for: [
                TripPreferences.self,
                challengeData.self
            ],inMemory: true
        )
    }
}
