//
//  MyJourneyView.swift
//  QVoyage
//

import SwiftUI
import SwiftData
import UIKit

struct MyJourneyView: View {

    // MARK: - Trip

    @Bindable var trip: TripPreferences
    @State private var goToNextPage = false


    // MARK: - First Photo

    private var firstPhoto: UIImage? {

        let sortedChallenges =
            trip.challenges.sorted {
                $0.day < $1.day
            }

        for challenge in sortedChallenges {

            if let imageData = challenge.imageData,
               let image = UIImage(data: imageData) {

                return image
            }
        }

        return nil
    }


    // MARK: - Date

    private var dateText: String {

        guard let startDate = trip.startDate else {
            return ""
        }

        let formatter = DateFormatter()

        formatter.dateFormat = "MMMM yyyy"

        return formatter.string(
            from: startDate
        )
    }


    // MARK: - Body

    var body: some View {

        ZStack {

            Color("Backgroundcolor")
                .ignoresSafeArea()


            VStack(
                alignment: .leading,
                spacing: 0
            ) {

                // MARK: - Header

                JournalHeader(
                    country: trip.country,
                    showNextButton: true
                ) {

                    // بعد My Journey
                    // يفتح Travel Story

                    journals_page_story_(
                        trip: trip
                    )
                }


                // MARK: - Book

                ZStack {

                    // MARK: Book Background

                    BookSideView(
                        side: .left
                    )
                    .offset(
                        x: 7,
                        y: -10
                    )
                    .frame(
                        width: 690,
                        height: 505
                    )
                    
                    


                    // MARK: - Book Header

                    VStack(
                        spacing: 6
                    ) {

                        Text(
                            "My Journey"
                        )
                        .font(
                            .system(
                                size: 30,
                                weight: .bold,
                                design: .serif
                            )
                        )


                        Text(
                            trip.country
                        )
                        .font(
                            .system(
                                size: 20,
                                weight: .bold,
                                design: .serif
                            )
                        )


                        Text(
                            dateText
                        )
                        .font(
                            .system(
                                size: 15,
                                weight: .bold,
                                design: .serif
                            )
                        )
                    }
                    .foregroundStyle(
                        Color("FontColor")
                    )
                    .offset(
                        y: -180
                    )


                    // MARK: - Passport Sticker

                    Image(
                        "PassportSticker"
                    )
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 65
                    )
                    .rotationEffect(
                        .degrees(22)
                    )
                    .offset(
                        x: -90,
                        y: -110
                    )


                    // MARK: - Polaroid

                    ZStack {

                        Image(
                            "PolaroidFrame"
                        )
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 140,
                            height: 220
                        )


                        if let firstPhoto {

                            Image(
                                uiImage: firstPhoto
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
                                    .opacity(
                                        0.12
                                    )


                                Image(
                                    systemName: "photo"
                                )
                                .font(
                                    .system(
                                        size: 30
                                    )
                                )
                                .foregroundStyle(
                                    Color("FontColor")
                                        .opacity(
                                            0.45
                                        )
                                )
                            }
                            .frame(
                                width: 109,
                                height: 145.5
                            )
                            .clipped()
                            .offset(
                                x: 4,
                                y: -8
                            )
                        }
                    }
                    .rotationEffect(
                        .degrees(-9)
                    )
                    .offset(
                        x: 15,
                        y: -35
                    )


                    // MARK: - Character

                    Image(
                        "TravelerCharacter"
                    )
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 100
                    )
                    .offset(
                        x: -80,
                        y: 100
                    )


                    // MARK: - Note

                    ZStack {

                        Image(
                            "NotePaper"
                        )
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 165
                        )


                        Text(
                            """
                            Collect moments not
                            things!
                            """
                        )
                        .font(
                            .system(
                                size: 17,
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
                            width: 120
                        )
                    }
                    .offset(
                        x: 60,
                        y: 120
                    )


                    // MARK: - Air Mail

                    Image(
                        "AirMailSticker"
                    )
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 75
                    )
                    .rotationEffect(
                        .degrees(-1)
                    )
                    .offset(
                        x: 135,
                        y: 20
                    )
                }
                .frame(
                    width: 370,
                    height: 520
                )
                .padding(
                    .top,
                    40
                )
                .gesture(
                    DragGesture(
                        minimumDistance: 50
                    )
                    .onEnded { value in

                        // سحب لليسار → الصفحة التالية

                        if value.translation.width < -80 {

                            goToNextPage = true
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
        .navigationDestination(
            isPresented: $goToNextPage
        ) {

            journals_page_story_(
                trip: trip
            )
        }
        .toolbar(
            .hidden,
            for: .navigationBar
        )
    }
}


// MARK: - Preview

#Preview {

    NavigationStack {

        MyJourneyView(

            trip:
                TripPreferences(

                    country: "Spain",

                    startDate:
                        Date(),

                    endDate:
                        Calendar.current.date(
                            byAdding: .day,
                            value: 4,
                            to: Date()
                        ),

                    travelWith: "Solo",

                    difficulty: "Easy",

                    photographyInterests: [
                        "Architecture",
                        "Food"
                    ],

                    avoid: []
                )
        )
    }
}
