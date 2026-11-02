//
//  TripPreferences.swift
//  Memora
//

import Foundation
import SwiftData

@Model
final class TripPreferences {

    // MARK: - Trip Info

    var country: String

    var startDate: Date?

    var endDate: Date?


    // MARK: - Preferences

    var travelWith: String?

    var difficulty: String?

    var photographyInterests: [String]

    var avoid: [String]


    // MARK: - AI Story

    var generatedStory: String


    // MARK: - Challenges

    @Relationship(
        deleteRule: .cascade,
        inverse: \challengeData.trip
    )
    var challenges: [challengeData]


    // MARK: - Init

    init(
        country: String,
        startDate: Date? = nil,
        endDate: Date? = nil,
        travelWith: String? = nil,
        difficulty: String? = nil,
        photographyInterests: [String] = [],
        avoid: [String] = [],
        generatedStory: String = "",
        challenges: [challengeData] = []
    ) {

        self.country = country

        self.startDate = startDate

        self.endDate = endDate

        self.travelWith = travelWith

        self.difficulty = difficulty

        self.photographyInterests =
            photographyInterests

        self.avoid = avoid

        self.generatedStory =
            generatedStory

        self.challenges =
            challenges
    }
}
