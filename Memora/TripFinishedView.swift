//
//  TripFinishedView.swift
//  Memora
//

import SwiftUI
import SwiftData

struct TripFinishedView: View {

    // MARK: - Trip

    @Bindable var trip: TripPreferences


    // MARK: - Navigation

    @State private var goToNewTrip = false


    // MARK: - Body

    var body: some View {

        ZStack {

            // MARK: Background

            Color("Backgroundcolor")
                .ignoresSafeArea()


            // MARK: Scrollable Content

            ScrollView(
                .vertical,
                showsIndicators: false
            ) {

                VStack(
                    spacing: 0
                ) {

                    // MARK: Top Space

                    Spacer()
                        .frame(
                            height: 40
                        )


                    // MARK: Character

                    Image("CharacterWithBag")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 180,
                            height: 180
                        )
                        .padding(
                            .bottom,
                            10
                        )


                    // MARK: Title

                    Text(
                        "Journey Complete!"
                    )
                    .font(
                        .system(
                            size: 34,
                            weight: .bold,
                            design: .serif
                        )
                    )
                    .foregroundStyle(
                        Color("FontColor")
                    )
                    .multilineTextAlignment(
                        .center
                    )


                    // MARK: Message

                    Text(
                        """
                        You completed your journey
                        one day at a time!
                        """
                    )
                    .font(
                        .system(
                            size: 20,
                            design: .serif
                        )
                    )
                    .foregroundStyle(
                        Color("FontColor")
                            .opacity(0.85)
                    )
                    .multilineTextAlignment(
                        .center
                    )
                    .padding(
                        .top,
                        12
                    )


                    // MARK: Country

                    Text(
                        trip.country
                    )
                    .font(
                        .system(
                            size: 27,
                            weight: .bold,
                            design: .serif
                        )
                    )
                    .foregroundStyle(
                        Color("buttoncolor")
                    )
                    .padding(
                        .top,
                        20
                    )


                    // MARK: Completion Card

                    VStack(
                        spacing: 12
                    ) {

                        Image(
                            systemName:
                                "checkmark.circle.fill"
                        )
                        .font(
                            .system(
                                size: 42
                            )
                        )
                        .foregroundStyle(
                            Color("buttoncolor")
                        )


                        Text(
                            "All quests completed"
                        )
                        .font(
                            .system(
                                size: 18,
                                weight: .bold,
                                design: .serif
                            )
                        )
                        .foregroundStyle(
                            Color("FontColor")
                        )


                        Text(
                            """
                            You captured the moments,
                            completed the challenges,
                            and made your journey yours.
                            """
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
                    }
                    .frame(
                        maxWidth: .infinity
                    )
                    .padding(
                        .vertical,
                        22
                    )
                    .background(
                        Color("Backgroundcolor")
                    )
                    .overlay {

                        RoundedRectangle(
                            cornerRadius: 20
                        )
                        .stroke(
                            Color("FontColor"),
                            lineWidth: 2
                        )
                    }
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 20
                        )
                    )
                    .padding(
                        .horizontal,
                        35
                    )
                    .padding(
                        .top,
                        30
                    )


                    // MARK: - Start New Trip

                    Button {

                        goToNewTrip = true

                    } label: {

                        HStack(
                            spacing: 12
                        ) {

                            Text(
                                "Start New Trip"
                            )

                            Image(
                                systemName:
                                    "plus"
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
                            Color("FontColor")
                        )
                        .frame(
                            maxWidth: .infinity
                        )
                        .frame(
                            height: 55
                        )
                        .background(
                            Color("Backgroundcolor")
                        )
                        .overlay {

                            Capsule()
                                .stroke(
                                    Color("buttoncolor"),
                                    lineWidth: 2
                                )
                        }
                    }
                    .padding(
                        .horizontal,
                        45
                    )
                    .padding(
                        .top,
                        30
                    )


                    // MARK: Bottom Message

                    Text(
                        "Thank you for traveling with QVoyage ✨"
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
                    .padding(
                        .top,
                        25
                    )


                    // MARK: Bottom Scroll Space

                    Spacer()
                        .frame(
                            height: 130
                        )
                }
                .frame(
                    maxWidth: .infinity
                )
            }
        }


        // MARK: - Start New Trip Navigation

        .fullScreenCover(
            isPresented:
                $goToNewTrip
        ) {

            NavigationStack {

                SwiftUIView(
                    showBackButton: true
                )
                .navigationBarBackButtonHidden(
                    true
                )
            }
        }
    }
}


// MARK: - Preview

#Preview {

    NavigationStack {

        TripFinishedView(

            trip:
                TripPreferences(

                    country:
                        "Japan",

                    startDate:
                        Calendar.current.date(
                            byAdding:
                                .day,
                            value:
                                -5,
                            to:
                                Date()
                        ),

                    endDate:
                        Date(),

                    travelWith:
                        "Solo",

                    difficulty:
                        "Easy",

                    photographyInterests:
                        [
                            "Architecture",
                            "Food"
                        ],

                    avoid:
                        []
                )
        )
    }
}
