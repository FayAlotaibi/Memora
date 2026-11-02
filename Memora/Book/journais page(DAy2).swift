//
//  journais page(DAy2).swift
//  QVoyage
//

import SwiftUI
import SwiftData
import UIKit

struct JournalDayView: View {

    // MARK: - Trip

    @Bindable var trip: TripPreferences

    // MARK: - Navigation

    @State private var goToNextPage = false
    @State private var goToJournals = false

    @Environment(\.dismiss)
    private var dismiss

    // MARK: - Day

    let dayNumber: Int


    // MARK: - Challenges

    private var sortedChallenges: [challengeData] {

        trip.challenges.sorted {
            $0.day < $1.day
        }
    }


    // MARK: - Current Challenge

    private var currentChallenge: challengeData? {

        sortedChallenges.first {
            $0.day == dayNumber
        }
    }


    // MARK: - Total Days

    private var totalDays: Int {

        sortedChallenges.count
    }


    // MARK: - Has Next Day

    private var hasNextDay: Bool {

        dayNumber < totalDays
    }


    // MARK: - Is Last Day

    private var isLastDay: Bool {

        dayNumber == totalDays
    }


    // MARK: - User Photo

    private var userPhoto: UIImage? {

        guard let imageData =
                currentChallenge?.imageData
        else {
            return nil
        }

        return UIImage(
            data: imageData
        )
    }


    // MARK: - Challenge Text

    private var challengeText: String {

        currentChallenge?.challengeText
        ?? "Today's challenge"
    }


    // MARK: - Note Text

    private var noteText: String {

        guard let note =
                currentChallenge?.note,
              !note.isEmpty
        else {

            return ""
        }

        return note
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

                // MARK: Header

                JournalHeader(
                    country: trip.country,
                    showNextButton: hasNextDay
                ) {

                    nextPage
                }


                // MARK: Book

                ZStack {

                    BookSideView(
                        side: .right
                    )
                    .frame(
                        width: 400,
                        height: 650
                    )
                    .offset(
                        x: -2,
                        y: 20
                    )


                    // MARK: Day Number

                    Text(
                        "Day \(dayNumber)"
                    )
                    .font(
                        .system(
                            size: 38,
                            weight: .medium,
                            design: .serif
                        )
                    )
                    .foregroundStyle(
                        Color("FontColor")
                    )
                    .offset(
                        x: -25,
                        y: -190
                    )


                    // MARK: Photo

                    ZStack {

                        Image("PolaroidFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 140,
                                height: 220
                            )


                        if let userPhoto {

                            Image(
                                uiImage: userPhoto
                            )
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: 109,
                                height: 145.5
                            )
                            .clipped()
                            .offset(
                                x: 4,
                                y: -8
                            )

                        } else {

                            ZStack {

                                Color("buttoncolor")
                                    .opacity(0.12)


                                Image(
                                    systemName: "photo"
                                )
                                .font(
                                    .system(
                                        size: 25
                                    )
                                )
                                .foregroundStyle(
                                    Color("FontColor")
                                        .opacity(0.45)
                                )
                            }
                            .frame(
                                width: 155,
                                height: 145
                            )
                            .offset(
                                x: 5,
                                y: -12
                            )
                        }
                    }
                    .offset(
                        x: -25,
                        y: -10
                    )


                    // MARK: Camera Sticker

                    Image("camera")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 120
                        )
                        .rotationEffect(
                            .degrees(-8)
                        )
                        .offset(
                            x: -110,
                            y: -130
                        )


                    // MARK: Travel Sticker

                    Image("travelSticker")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 90
                        )
                        .rotationEffect(
                            .degrees(8)
                        )
                        .offset(
                            x: 90,
                            y: 140
                        )


                    // MARK: Challenge + Note

                    VStack(
                        spacing: 8
                    ) {

                        // Challenge

                        Text(
                            challengeText
                        )
                        .font(
                            .system(
                                size: 21,
                                weight: .medium,
                                design: .serif
                            )
                        )
                        .foregroundStyle(
                            Color("FontColor")
                        )
                        .multilineTextAlignment(
                            .center
                        )
                        .frame(
                            width: 240
                        )


                        // Note

                        if !noteText.isEmpty {

                            Text(
                                noteText
                            )
                            .font(
                                .system(
                                    size: 15,
                                    design: .serif
                                )
                            )
                            .foregroundStyle(
                                Color("FontColor")
                                    .opacity(0.75)
                            )
                            .multilineTextAlignment(
                                .center
                            )
                            .frame(
                                width: 220
                            )
                            .lineLimit(3)
                        }
                    }
                    .offset(
                        x: -38,
                        y: 130
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

                // MARK: Swipe Gesture

                .gesture(

                    DragGesture(
                        minimumDistance: 50
                    )
                    .onEnded { value in

                        // Swipe Left
                        // Go to next day

                        if value.translation.width < -80,
                           hasNextDay {

                            goToNextPage = true
                        }

                        // Swipe Right
                        // Go to previous page

                        else if value.translation.width > 80 {

                            dismiss()
                        }
                    }
                )


                // MARK: - Last Day Button

                if isLastDay {

                    Button {

                        goToJournals = true

                    } label: {

                        HStack(
                            spacing: 10
                        ) {

                            Image(
                                systemName: "book.pages"
                            )


                            Text(
                                "Back to My Journeys"
                            )
                        }
                        .font(
                            .system(
                                size: 18,
                                weight: .semibold,
                                design: .serif
                            )
                        )
                        .foregroundStyle(
                            .white
                        )
                        .frame(
                            maxWidth: .infinity
                        )
                        .frame(
                            height: 55
                        )
                        .background(
                            Color("buttoncolor")
                        )
                        .clipShape(
                            Capsule()
                        )
                    }
                    .buttonStyle(
                        .plain
                    )
                    .padding(
                        .horizontal,
                        45
                    )
                    .padding(
                        .top,
                        5
                    )
                }


                Spacer()
            }
            .padding(
                .horizontal,
                25
            )
        }


        // MARK: - Next Day Navigation

        .navigationDestination(
            isPresented: $goToNextPage
        ) {

            nextPage
        }


        // MARK: - Back To My Journeys
        //
        // IMPORTANT:
        // نرجع إلى CustomTabView وليس Journals مباشرة
        // حتى يظهر الـ bottom menu bar.

        .navigationDestination(
            isPresented: $goToJournals
        ) {

            CustomTabView(
                trip: trip,
                selectedTab: 1
            )
            .navigationBarBackButtonHidden(
                true
            )
        }


        // MARK: Hide Default Navigation Bar

        .toolbar(
            .hidden,
            for: .navigationBar
        )
    }


    // MARK: - Next Page

    @ViewBuilder
    private var nextPage: some View {

        let nextDay =
            dayNumber + 1


        if hasNextDay {

            // Even Days

            if nextDay % 2 == 0 {

                JournalDayView(
                    trip: trip,
                    dayNumber: nextDay
                )

            }

            // Odd Days

            else {

                JournalDay1(
                    trip: trip,
                    dayNumber: nextDay
                )
            }

        } else {

            EmptyView()
        }
    }
}


// MARK: - Preview

#Preview {

    NavigationStack {

        JournalDayView(

            trip:
                TripPreferences(

                    country:
                        "France",

                    startDate:
                        Date(),

                    endDate:
                        Calendar.current.date(
                            byAdding: .day,
                            value: 2,
                            to: Date()
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
                ),

            dayNumber: 2
        )
    }
}
