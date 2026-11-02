//
//  journais page(story).swift
//  QVoyage
//
//  Created by Lujain on 21/02/1448 AH.
//

import SwiftUI
import SwiftData

struct journals_page_story_: View {

    // MARK: - Trip

    @Bindable var trip: TripPreferences

    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss


    // MARK: - Story State

    @State private var story: String = ""

    @State private var isGeneratingStory = false

    @State private var storyError: String?


    // MARK: - Has Days

    private var hasDays: Bool {

        !trip.challenges.isEmpty
    }


    // MARK: - Body

    var body: some View {

        ZStack {

            // MARK: Background

            Color("Backgroundcolor")
                .ignoresSafeArea()


            VStack(
                alignment: .leading,
                spacing: 0
            ) {

                // MARK: - Shared Header

                JournalHeader(
                    country: trip.country,
                    showNextButton: hasDays
                ) {

                    if hasDays {

                        JournalDay1(
                            trip: trip,
                            dayNumber: 1
                        )

                    } else {

                        EmptyView()
                    }
                }


                // MARK: - Story Book

                ZStack {

                    // MARK: Book Image

                    BookSideView(
                        side: .right
                    )
                    .frame(
                        width: 400,
                        height: 540
                    )
                    .offset(
                        x: -8,
                        y: 20
                    )


                    // MARK: Story Content

                    VStack(
                        spacing: 2
                    ) {

                        // MARK: Title

                        Text("Travel Story")
                            .font(
                                .system(
                                    size: 30,
                                    weight: .medium,
                                    design: .serif
                                )
                            )
                            .foregroundStyle(
                                Color("FontColor")
                            )
                            .frame(
                                width: 260
                            )


                        // MARK: Loading

                        if isGeneratingStory {

                            VStack(
                                spacing: -1
                            ) {

                                ProgressView()
                                    .tint(
                                        Color("buttoncolor")
                                    )
                                    .scaleEffect(1.2)


                                Text(
                                    "Writing your travel story..."
                                )
                                .font(
                                    .system(
                                        size: 15,
                                        design: .serif
                                    )
                                )
                                .foregroundStyle(
                                    Color("FontColor")
                                        .opacity(0.7)
                                )
                            }
                            .frame(
                                width: 260,
                                height: 350
                            )


                        } else if let storyError {

                            // MARK: Error

                            Text(storyError)
                                .font(
                                    .system(
                                        size: 14,
                                        design: .serif
                                    )
                                )
                                .foregroundStyle(
                                    Color("FontColor")
                                        .opacity(0.7)
                                )
                                .multilineTextAlignment(
                                    .center
                                )
                                .frame(
                                    width: 250,
                                    height: 350
                                )


                        } else {

                            // MARK: Generated Story

                            ScrollView(.vertical, showsIndicators: false) {
                                Text(story)
                                    .font(
                                        .system(
                                            size: 16,
                                            design: .serif
                                        )
                                    )
                                    .foregroundStyle(
                                        Color("FontColor")
                                    )
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(5)
                                    .frame(
                                        width: 260
                                    )
                                    .padding(.vertical, 10)
                            }
                            .frame(
                                width: 260,
                                height: 340
                            )
                            .clipped()
                            
                        }
                    }
                    .frame(
                        width: 280,
                        height: 430
                    )
                    .offset(
                        x: -40,
                        y: -35
                    )
                }
                .frame(
                    width: 370,
                    height: 520
                )
                .padding(
                    .top,
                    35
                )


                // MARK: - Swipe Back

                .gesture(

                    DragGesture(
                        minimumDistance: 50
                    )
                    .onEnded { value in

                        // Swipe right → previous page

                        if value.translation.width > 80 {

                            dismiss()
                        }
                    }
                )


                Spacer()
            }
            .padding(
                .horizontal,
                25
            )
        }


        // MARK: - Generate Story

        .task {

            await loadJourneyStory()
        }


        .toolbar(
            .hidden,
            for: .navigationBar
        )
    }


    // MARK: - Load / Generate Story

    @MainActor
    private func loadJourneyStory() async {

        // MARK: - Story already exists
        // Load it instead of generating again

        if !trip.generatedStory.isEmpty {

            story = trip.generatedStory

            print("📖 Loaded saved story")

            return
        }


        // MARK: - Prevent duplicate generation

        guard !isGeneratingStory else {
            return
        }


        isGeneratingStory = true
        storyError = nil


        do {

            let generator = JourneyStoryGenerator()


            let generatedStory =
                try await generator.generateStory(

                    country:
                        trip.country,

                    challenges:
                        trip.challenges
                )


            // MARK: - Show story

            story = generatedStory


            // MARK: - Save story to SwiftData

            trip.generatedStory = generatedStory


            // MARK: - Persist changes

            try modelContext.save()


            print(
                "========== GENERATED & SAVED STORY =========="
            )

            print(
                generatedStory
            )

            print(
                "============================================="
            )


            isGeneratingStory = false


        } catch {

            isGeneratingStory = false


            storyError =
                """
                We couldn't create your travel story right now.
                """


            print(
                "❌ Story generation error:",
                error
            )
        }
    }
}


// MARK: - Preview

#Preview {

    NavigationStack {

        journals_page_story_(

            trip:
                TripPreferences(

                    country:
                        "Italy",

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
                        "Easy",

                    photographyInterests: [
                        "Architecture",
                        "Food"
                    ],

                    avoid: []
                )
        )
    }
}
