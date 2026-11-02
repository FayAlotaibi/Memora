//
//  challengeData.swift
//  Memora
//

import Foundation
import SwiftData

@Model
final class challengeData {

    // MARK: - Challenge Info

    var day: Int

    var challengeText: String

    var challengeDetailSheet: String


    // MARK: - User Data

    var note: String

    var imageData: Data?

    var isCompleted: Bool


    // MARK: - Trip Relationship

    var trip: TripPreferences?


    // MARK: - Init

    init(
        day: Int,
        challengeText: String,
        challengeDetailSheet: String,
        note: String = "",
        imageData: Data? = nil,
        isCompleted: Bool = false,
        trip: TripPreferences? = nil
    ) {

        self.day =
            day

        self.challengeText =
            challengeText

        self.challengeDetailSheet =
            challengeDetailSheet

        self.note =
            note

        self.imageData =
            imageData

        self.isCompleted =
            isCompleted

        self.trip =
            trip
    }
}
