//
//  ChallengeGenerator.swift
//  Memora
//

import Foundation
import FoundationModels

@MainActor
final class ChallengeGenerator {

    // MARK: - AI Session

    private let session = LanguageModelSession(
        instructions: """
        You are an AI travel photography challenge generator
        for the QVoyage app.

        Your job is to create safe, creative,
        destination-aware photography challenges.

        IMPORTANT RULES:

        - Every challenge MUST require taking a photo.
        - No selfies.
        - No interacting with strangers.
        - No dangerous activities.
        - No paid activities.
        - No long walks.
        - Challenges must be realistic for travelers.
        - Challenges must match the destination.
        - Respect the travel style.
        - Respect the requested difficulty.
        - Respect photography interests.
        - Respect anything the traveler wants to avoid.
        - Keep the title short.
        - Keep the description to one clear sentence.
        - Do not repeat previous challenges.
        """
    )


    // MARK: - Generate All Challenges

    func generateChallenges(
        country: String,
        numberOfDays: Int,
        travelStyle: String,
        difficulty: String,
        photographyInterests: [String],
        avoid: [String]
    ) async throws -> [TravelChallenge] {

        let days =
            max(
                1,
                numberOfDays
            )


        let interests =
            photographyInterests.isEmpty
            ? "No specific photography interests"
            : photographyInterests.joined(
                separator: ", "
            )


        let avoidList =
            avoid.isEmpty
            ? "Nothing specific"
            : avoid.joined(
                separator: ", "
            )


        var generatedChallenges:
            [TravelChallenge] = []


        // MARK: Generate One Challenge Per Day

        for day in 1...days {

            let previousTitles =
                generatedChallenges
                    .map {
                        $0.title
                    }
                    .joined(
                        separator: ", "
                    )


            let challenge =
                await generateSingleChallenge(
                    country: country,
                    day: day,
                    totalDays: days,
                    travelStyle: travelStyle,
                    difficulty: difficulty,
                    interests: interests,
                    avoidList: avoidList,
                    previousTitles: previousTitles
                )


            generatedChallenges.append(
                challenge
            )
        }


        // MARK: Final Safety Check

        guard generatedChallenges.count == days else {

            throw ChallengeGenerationError
                .invalidCount(
                    expected: days,
                    received:
                        generatedChallenges.count
                )
        }


        return generatedChallenges
    }


    // MARK: - Generate Single Day

    private func generateSingleChallenge(
        country: String,
        day: Int,
        totalDays: Int,
        travelStyle: String,
        difficulty: String,
        interests: String,
        avoidList: String,
        previousTitles: String
    ) async -> TravelChallenge {

        let prompt = """
        Generate ONE photography challenge for this trip.

        Destination:
        \(country)

        Day:
        \(day) of \(totalDays)

        Travel style:
        \(travelStyle)

        Difficulty:
        \(difficulty)

        Photography interests:
        \(interests)

        Things to avoid:
        \(avoidList)

        Previous challenge titles:
        \(previousTitles.isEmpty ? "None" : previousTitles)


        IMPORTANT:

        Generate exactly ONE challenge.

        The challenge MUST:
        - require taking a photo
        - be suitable for Day \(day)
        - be different from previous challenges
        - be appropriate for \(country)
        - match the requested difficulty
        - respect the photography interests
        - respect the avoid list
        - be safe
        - not require a selfie
        - not require interacting with strangers
        - not require paying money
        - not require dangerous activities
        - not require a long walk

        Return:
        - title
        - description
        - difficulty
        """


        // MARK: First Attempt

        do {

            let response =
                try await session.respond(
                    to: prompt,
                    generating:
                        TravelChallenge.self
                )


            return response.content

        } catch {

            print(
                "⚠️ Day \(day) generation attempt 1 failed:",
                error
            )
        }


        // MARK: Second Attempt

        do {

            let retryPrompt = """
            Create exactly ONE simple photography challenge.

            Destination:
            \(country)

            Day:
            \(day)

            Difficulty:
            \(difficulty)

            The traveler must take a photo.

            Do not create a selfie challenge.
            Do not involve strangers.
            Do not require payment.
            Keep it safe and simple.

            Return:
            title
            description
            difficulty
            """


            let response =
                try await session.respond(
                    to: retryPrompt,
                    generating:
                        TravelChallenge.self
                )


            return response.content

        } catch {

            print(
                "⚠️ Day \(day) generation attempt 2 failed:",
                error
            )
        }


        // MARK: Local Fallback

        /*
         إذا فشل الـ AI مرتين،
         لا نترك اليوم بدون Challenge.

         بهذا نضمن أن:
         عدد Challenges = عدد الأيام دائماً.
        */

        return fallbackChallenge(
            day: day,
            country: country,
            difficulty: difficulty
        )
    }


    // MARK: - Fallback Challenge

    private func fallbackChallenge(
        day: Int,
        country: String,
        difficulty: String
    ) -> TravelChallenge {

        let fallbackOptions: [
            (
                title: String,
                description: String
            )
        ] = [

            (
                title:
                    "Local Colors",

                description:
                    "Photograph an interesting color or detail that catches your eye while exploring \(country)."
            ),

            (
                title:
                    "Travel Detail",

                description:
                    "Capture a small architectural or cultural detail that reminds you of \(country)."
            ),

            (
                title:
                    "Local Flavor",

                description:
                    "Photograph a local meal, snack, or drink that represents your day in \(country)."
            ),

            (
                title:
                    "Street Moment",

                description:
                    "Capture an interesting street, building, or scene that reflects the atmosphere of \(country)."
            ),

            (
                title:
                    "Beautiful View",

                description:
                    "Photograph a beautiful view or landscape you discover during your day in \(country)."
            ),

            (
                title:
                    "Hidden Detail",

                description:
                    "Take a photo of a unique texture, sign, doorway, or detail you notice in \(country)."
            )
        ]


        let index =
            (day - 1)
            % fallbackOptions.count


        let option =
            fallbackOptions[index]


        return TravelChallenge(
            title:
                option.title,

            description:
                option.description,

            difficulty:
                difficulty
        )
    }
}


// MARK: - Challenge Generation Error

enum ChallengeGenerationError:
    LocalizedError {

    case invalidCount(
        expected: Int,
        received: Int
    )


    var errorDescription: String? {

        switch self {

        case let .invalidCount(
            expected,
            received
        ):

            return """
            Challenge generation returned \(received) challenges,
            but \(expected) were required.
            """
        }
    }
}
