//
//  FinalQuestView.swift
//  Memora
//

import SwiftUI
import SwiftData
import Foundation
import FoundationModels

struct FinalQuestView: View {

    // MARK: - Navigation

    @State private var goToMainPage =
        false


    // MARK: - Generation

    @State private var isGenerating =
        false

    @State private var errorMessage:
        String?


    // MARK: - Trip

    @Bindable var trip:
        TripPreferences


    // MARK: - SwiftData

    @Environment(\.modelContext)
    private var modelContext


    // MARK: - Number Of Trip Days

    private var numberOfDays: Int {

        guard
            let startDate =
                trip.startDate,

            let endDate =
                trip.endDate

        else {

            return 1
        }


        let calendar =
            Calendar.current


        let start =
            calendar.startOfDay(
                for: startDate
            )


        let end =
            calendar.startOfDay(
                for: endDate
            )


        let difference =
            calendar.dateComponents(
                [.day],
                from: start,
                to: end
            ).day ?? 0


        return max(
            1,
            difference + 1
        )
    }


    // MARK: - Body

    var body: some View {

        ZStack {

            Color("Backgroundcolor")
                .ignoresSafeArea()


            VStack(
                spacing: 0
            ) {

                // MARK: Title

                Text(
                    """
                    We're creating your
                     personalized quest! ✨
                    """
                )
                .font(
                    .system(
                        size: 28,
                        weight: .bold,
                        design: .serif
                    )
                )
                .foregroundStyle(
                    Color("FontColor")
                )
                .multilineTextAlignment(
                    .leading
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )


                // MARK: Image

                Image("finalPic")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        height: 160
                    )
                    .padding(
                        .top,
                        55
                    )


                // MARK: Steps

                VStack(
                    alignment: .leading,
                    spacing: 22
                ) {

                    HStack(
                        spacing: 12
                    ) {

                        Image(
                            systemName:
                                "checkmark.circle"
                        )
                        .foregroundStyle(
                            Color("buttoncolor")
                        )


                        Text(
                            "Analyzing your destination"
                        )
                    }


                    HStack(
                        spacing: 12
                    ) {

                        Image(
                            systemName:
                                "checkmark.circle"
                        )
                        .foregroundStyle(
                            Color("buttoncolor")
                        )


                        Text(
                            "Understanding your preferences"
                        )
                    }


                    HStack(
                        spacing: 12
                    ) {

                        Image(
                            systemName:
                                "checkmark.circle"
                        )
                        .foregroundStyle(
                            Color("buttoncolor")
                        )


                        Text(
                            "Finding unique experiences"
                        )
                    }


                    HStack(
                        spacing: 12
                    ) {

                        if isGenerating {

                            ProgressView()
                                .tint(
                                    Color(
                                        "buttoncolor"
                                    )
                                )

                        } else {

                            Image(
                                systemName:
                                    "checkmark.circle"
                            )
                            .foregroundStyle(
                                Color(
                                    "buttoncolor"
                                )
                            )
                        }


                        Text(
                            "Generating your travel journal"
                        )
                    }
                }
                .font(
                    .system(
                        size: 18,
                        weight: .medium,
                        design: .serif
                    )
                )
                .foregroundStyle(
                    Color("FontColor")
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(
                    .top,
                    55
                )


                // MARK: Quest Count

                Text(
                    "Creating \(numberOfDays) personalized quest\(numberOfDays == 1 ? "" : "s")..."
                )
                .font(
                    .system(
                        size: 18,
                        weight: .medium,
                        design: .serif
                    )
                )
                .foregroundStyle(
                    Color("FontColor")
                )
                .padding(
                    .top,
                    65
                )


                Image(
                    systemName:
                        "heart.fill"
                )
                .font(
                    .system(
                        size: 34
                    )
                )
                .foregroundStyle(
                    Color("buttoncolor")
                )
                .padding(
                    .top,
                    18
                )


                // MARK: Error

                if let errorMessage {

                    Text(
                        errorMessage
                    )
                    .font(
                        .system(
                            size: 14,
                            design: .serif
                        )
                    )
                    .foregroundStyle(
                        .red
                    )
                    .multilineTextAlignment(
                        .center
                    )
                    .padding(
                        .top,
                        20
                    )
                }


                Spacer()
            }
            .padding(
                .horizontal,
                30
            )
            .padding(
                .top,
                75
            )
        }


        // MARK: - Generate Challenges

        .task {

            await generateTripChallenges()
        }


        // MARK: - Navigation

        .navigationDestination(
            isPresented:
                $goToMainPage
        ) {

            CustomTabView(
                trip: trip
            )
            .navigationBarBackButtonHidden(
                true
            )
        }


        .navigationBarBackButtonHidden(
            true
        )
    }


    // MARK: - Generate Trip Challenges

    @MainActor
    private func generateTripChallenges()
        async {

        // منع التوليد مرتين

        guard !isGenerating else {
            return
        }


        isGenerating =
            true


        errorMessage =
            nil


        let generationStartTime =
            Date()


        do {

            print(
                "========== GENERATING TRIP =========="
            )

            print(
                "Country:",
                trip.country
            )

            print(
                "Days:",
                numberOfDays
            )


            // MARK: - Generator

            let generator =
                ChallengeGenerator()


            // MARK: - Generate AI Challenges

            let generatedChallenges =
                try await generator
                    .generateChallenges(

                        country:
                            trip.country,

                        numberOfDays:
                            numberOfDays,

                        travelStyle:
                            trip.travelWith
                            ?? "Solo",

                        difficulty:
                            trip.difficulty
                            ?? "Easy",

                        photographyInterests:
                            trip.photographyInterests,

                        avoid:
                            trip.avoid
                    )


            // MARK: Safety Check

            guard
                generatedChallenges.count
                ==
                numberOfDays

            else {

                throw ChallengeGenerationError
                    .invalidCount(

                        expected:
                            numberOfDays,

                        received:
                            generatedChallenges
                                .count
                    )
            }


            // ============================================
            // IMPORTANT:
            // DELETE ONLY THIS TRIP'S OLD CHALLENGES
            // ============================================

            let oldTripChallenges =
                Array(
                    trip.challenges
                )


            for oldChallenge
                in oldTripChallenges {

                modelContext.delete(
                    oldChallenge
                )
            }


            // Clear relationship

            trip.challenges
                .removeAll()


            // Save deletion first

            try modelContext.save()


            // MARK: - Create New Challenges

            for index
                in generatedChallenges.indices {

                let generated =
                    generatedChallenges[
                        index
                    ]


                let day =
                    index + 1


                let challenge =
                    challengeData(

                        day:
                            day,

                        challengeText:
                            generated.title,

                        challengeDetailSheet:
                            generated.description,

                        trip:
                            trip
                    )


                // كل Challenge جديد يبدأ غير مكتمل

                challenge.isCompleted =
                    false


                // Empty note

                challenge.note =
                    ""


                // Insert

                modelContext.insert(
                    challenge
                )


                // Relationship

                trip.challenges.append(
                    challenge
                )
            }


            // MARK: - Save SwiftData

            try modelContext.save()


            // ============================================
            // VERIFY SAVED CHALLENGES
            // ============================================

            let savedChallenges =
                trip.challenges
                    .sorted {
                        $0.day < $1.day
                    }


            print(
                "========== SAVED CHALLENGES =========="
            )


            for challenge
                in savedChallenges {

                print(
                    "Day:",
                    challenge.day
                )

                print(
                    "Challenge:",
                    challenge.challengeText
                )

                print(
                    "Completed:",
                    challenge.isCompleted
                )

                print(
                    "----------------------"
                )
            }


            print(
                "Expected:",
                numberOfDays
            )


            print(
                "Saved:",
                savedChallenges.count
            )


            print(
                "======================================"
            )


            // MARK: - Final Validation

            /*
             نتحقق من:

             Day 1 موجود
             Day 2 موجود
             Day 3 موجود
             ...
             حتى آخر يوم.
            */

            for day
                in 1...numberOfDays {

                guard
                    savedChallenges
                        .contains(
                            where: {
                                $0.day == day
                            }
                        )

                else {

                    throw FinalQuestError
                        .missingDay(
                            day
                        )
                }
            }


            guard
                savedChallenges.count
                ==
                numberOfDays

            else {

                throw FinalQuestError
                    .invalidSavedCount(

                        expected:
                            numberOfDays,

                        received:
                            savedChallenges.count
                    )
            }


            // MARK: - Minimum 3 Seconds

            let elapsed =
                Date()
                    .timeIntervalSince(
                        generationStartTime
                    )


            let remaining =
                max(
                    0,
                    3.0 - elapsed
                )


            if remaining > 0 {

                try await Task.sleep(
                    nanoseconds:
                        UInt64(
                            remaining
                            *
                            1_000_000_000
                        )
                )
            }


            // MARK: - Finish

            isGenerating =
                false


            /*
             ما ننتقل إلا بعد ما تأكدنا
             أن كل الأيام موجودة.
            */

            goToMainPage =
                true


        } catch {

            isGenerating =
                false


            errorMessage =
                """
                We couldn't prepare your journey.
                Please try again.
                """


            print(
                "❌ Challenge generation error:",
                error
            )
        }
    }
}


// MARK: - Final Quest Errors

enum FinalQuestError:
    LocalizedError {

    case missingDay(
        Int
    )

    case invalidSavedCount(
        expected: Int,
        received: Int
    )


    var errorDescription:
        String? {

        switch self {

        case let .missingDay(
            day
        ):

            return """
            Challenge for Day \(day) is missing.
            """


        case let .invalidSavedCount(
            expected,
            received
        ):

            return """
            Expected \(expected) saved challenges,
            but found \(received).
            """
        }
    }
}


// MARK: - Preview

#Preview {

    NavigationStack {

        FinalQuestView(

            trip:
                TripPreferences(

                    country:
                        "Spain",

                    startDate:
                        Date(),

                    endDate:
                        Calendar.current.date(
                            byAdding:
                                .day,
                            value:
                                4,
                            to:
                                Date()
                        ),

                    travelWith:
                        "Solo",

                    difficulty:
                        "Medium",

                    photographyInterests:
                        [
                            "Food",
                            "Landscapes",
                            "Architecture"
                        ],

                    avoid:
                        []
                )
        )
    }
}
