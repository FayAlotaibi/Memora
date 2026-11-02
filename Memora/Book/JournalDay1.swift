//
//  JournalDay1.swift
//  Memora
//

import SwiftUI
import SwiftData
import UIKit

struct JournalDay1: View {

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

            return "A memory from today."
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

                // MARK: - Header

                JournalHeader(
                    country: trip.country,
                    showNextButton: hasNextDay
                ) {

                    nextPage
                }


                // MARK: - Book

                ZStack {

                    BookSideView(
                        side: .left
                    )
                    .offset(
                        x: 17,
                        y: -8
                    )


                    // MARK: - Day

                    Text(
                        "Day \(dayNumber)"
                    )
                    .font(
                        .system(
                            size: 40,
                            weight: .medium,
                            design: .serif
                        )
                    )
                    .foregroundStyle(
                        Color("FontColor")
                    )
                    .offset(
                        x: 20,
                        y: -185
                    )


                    // MARK: - Photo

                    ZStack {

                        Image("PolaroidFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 130,
                                height: 220
                            )
                            .offset(
                                x: -25,
                                y: -55
                            )


                        if let userPhoto {

                            Image(
                                uiImage: userPhoto
                            )
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: 99,
                                height: 145
                            )
                            .clipped()
                            .offset(
                                x: -22,
                                y: -63
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
                                width: 99,
                                height: 145
                            )
                            .offset(
                                x: -22,
                                y: -63
                            )
                        }
                    }
                    .offset(
                        x: -25,
                        y: -10
                    )


                    // MARK: - Passport

                    Image("pass")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 110
                        )
                        .offset(
                            x: 115,
                            y: -135
                        )


                    // MARK: - Challenge

                    Text(
                        challengeText
                    )
                    .font(
                        .system(
                            size: 17,
                            weight: .medium,
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
                        width: 150,
                        alignment: .leading
                    )
                    .offset(
                        x: 100,
                        y: -35
                    )


                    // MARK: - Note

                    ZStack {

                        Image("oldframe")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 220
                            )


                        Text(
                            noteText
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
                        .multilineTextAlignment(
                            .center
                        )
                        .frame(
                            width: 150
                        )
                        .lineLimit(5)
                        .minimumScaleFactor(
                            0.7
                        )
                    }
                    .offset(
                        x: 15,
                        y: 105
                    )


                    // MARK: - Bag

                    Image("bag")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 95
                        )
                        .offset(
                            x: -85,
                            y: 150
                        )


                    // MARK: - Flower

                    Image("flv")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 95
                        )
                        .offset(
                            x: 110,
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


                // MARK: - Swipe Gesture

                .gesture(

                    DragGesture(
                        minimumDistance: 50
                    )
                    .onEnded { value in

                        // Swipe Left → Next Day

                        if value.translation.width < -80,
                           hasNextDay {

                            goToNextPage = true
                        }


                        // Swipe Right → Previous Page

                        else if value.translation.width > 80 {

                            dismiss()
                        }
                    }
                )


                // MARK: - Last Page Button

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


        // MARK: - Hide Default Navigation Bar

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

            // Even Day

            if nextDay % 2 == 0 {

                JournalDayView(
                    trip: trip,
                    dayNumber: nextDay
                )

            }

            // Odd Day

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

        JournalDay1(

            trip:
                TripPreferences(

                    country:
                        "Spain",

                    startDate:
                        Date(),

                    endDate:
                        Calendar.current.date(
                            byAdding: .day,
                            value: 4,
                            to: Date()
                        ),

                    travelWith:
                        "Friends",

                    difficulty:
                        "Easy",

                    photographyInterests: [
                        "Architecture",
                        "Food"
                    ],

                    avoid:
                        []
                ),

            dayNumber:
                1
        )
    }
}
