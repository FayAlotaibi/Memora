//
//  Memorypage.swift
//  Memora
//

import SwiftUI
import SwiftData

struct Memorypage: View {

    // MARK: - Trip

    @Bindable var trip: TripPreferences


    // MARK: - Body

    var body: some View {

        ZStack {

            Color("Backgroundcolor")
                .ignoresSafeArea()


            VStack(
                alignment: .leading,
                spacing: 0
            ) {

                // MARK: - Shared Header

                JournalHeader(
                    country: trip.country
                ) {

                    journals_page_story_(
                        trip: trip
                    )
                }


                // MARK: - Memory Book

                ZStack {

                    BookSideView(
                        side: .left
                    )
                    .offset(
                        x: 12,
                        y: -3
                    )
                    .frame(
                        width: 690,
                        height: 505
                    )
                    


                    // MARK: - Passport Sticker

                    Image("image7")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 60
                        )
                        .rotationEffect(
                            .degrees(-3)
                        )
                        .offset(
                            x: -90,
                            y: -170
                        )


                    // MARK: - Memory Title

                    Text("Memory")
                        .font(
                            .custom(
                                "Georgia",
                                size: 42
                            )
                        )
                        .foregroundStyle(
                            Color("FontColor")
                        )
                        .offset(
                            x: 23,
                            y: -165
                        )


                    // MARK: - Photo 1

                    ZStack {

                        Image("image 24")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 120,
                                height: 130
                            )
                            .offset(
                                x: 12,
                                y: -8
                            )


                        Image("Rectangle 79")
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: 73,
                                height: 110
                            )
                            .clipped()
                            .offset(
                                x: 12,
                                y: -8
                            )
                    }
                    .offset(
                        x: -70,
                        y: -54
                    )


                    // MARK: - Photo 2

                    ZStack {

                        Image("image 24")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 120,
                                height: 130
                            )
                            .offset(
                                x: -5,
                                y: -4
                            )


                        Image("Rectangle 80")
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: 73,
                                height: 110
                            )
                            .clipped()
                            .offset(
                                x: -5,
                                y: -8
                            )
                    }
                    .offset(
                        x: 70,
                        y: -53
                    )


                    // MARK: - Photo 3

                    ZStack {

                        Image("image 24")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 120,
                                height: 130
                            )
                            .offset(
                                x: 85,
                                y: -40
                            )


                        Image("Rectangle 81")
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: 73,
                                height: 104
                            )
                            .clipped()
                            .offset(
                                x: 85,
                                y: -45
                            )
                    }
                    .rotationEffect(
                        .degrees(-1)
                    )
                    .offset(
                        x: -140,
                        y: 140
                    )


                    // MARK: - Photo 4

                    ZStack {

                        Image("image 24")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 120,
                                height: 130
                            )
                            .offset(
                                x: 70,
                                y: -40
                            )


                        Image("Rectangle 78")
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: 73,
                                height: 104
                            )
                            .clipped()
                            .offset(
                                x: 70,
                                y: -45
                            )
                    }
                    .rotationEffect(
                        .degrees(1)
                    )
                    .offset(
                        x: 1,
                        y: 140
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


                Spacer()
            }
            .padding(
                .horizontal,
                25
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

        Memorypage(

            trip:
                TripPreferences(

                    country: "Italy",

                    startDate:
                        Date(),

                    endDate:
                        Calendar.current.date(
                            byAdding: .day,
                            value: 4,
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
                )
        )
    }
}
