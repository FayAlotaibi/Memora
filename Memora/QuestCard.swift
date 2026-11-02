import SwiftUI

struct QuestCard: View {

    let challenge: challengeData
    let trip: TripPreferences


    var body: some View {

        ZStack(alignment: .topTrailing) {

            HStack(
                alignment: .top,
                spacing: 5
            ) {

                // MARK: Left Icon

                RoundedRectangle(
                    cornerRadius: 20
                )
                .fill(
                    Color("Backgroundcolor")
                )
                .frame(
                    width: 120,
                    height: 135
                )
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 20
                    )
                    .stroke(
                        .black,
                        lineWidth: 1
                    )
                )
                .overlay {

                    Image(
                        systemName:
                            "photo.badge.plus.fill"
                    )
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 40,
                        height: 50
                    )
                    .foregroundStyle(
                        Color("buttoncolor")
                    )
                }


                // MARK: Challenge Information

                VStack(
                    alignment: .leading
                ) {

                    Text("Today's Quest!")
                        .font(
                            .system(
                                size: 19,
                                weight: .bold,
                                design: .serif
                            )
                        )
                        .foregroundStyle(
                            Color("FontColor")
                        )


                    Text(
                        challenge.challengeText
                    )
                    .font(
                        .system(
                            size: 18,
                            design: .serif
                        )
                    )
                    .foregroundStyle(
                        Color("FontColor")
                    )
                    .lineLimit(3)


                    Spacer()


                    // MARK: Start Button

                    HStack {

                        Spacer()
                        
                        

                        NavigationLink {

                            QuestDetailView(
                                challenge: challenge,
                                trip: trip
                            )
                            
                            

                        } label: {

                            HStack(spacing: 6) {

                                Text(
                                    "Start Your Quest"
                                )
                                .font(
                                    .system(
                                        size: 14,
                                        design: .serif
                                    )
                                )
                                .bold()


                                Image(
                                    systemName:
                                        "arrow.right"
                                )
                                .font(
                                    .system(size: 16)
                                )
                                .bold()
                            }

                            .foregroundStyle(.white)

                            .padding(
                                .horizontal,
                                5
                            )

                            .padding(
                                .vertical,
                                9
                            )

                            .background(
                                Color("buttoncolor")
                            )

                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 15
                                )
                            )
                        }
                    }
                }

                .padding(
                    .vertical,
                    8
                )
            }

            .padding()

            .frame(
                width:
                    UIScreen.main.bounds.width < 390
                    ? 320
                    : 380,
                height: 170
            )

            .background(
                Color("Backgroundcolor")
            )

            .overlay(
                RoundedRectangle(
                    cornerRadius: 20
                )
                .stroke(
                    .black,
                    lineWidth: 3
                )
            )

            .clipShape(
                RoundedRectangle(
                    cornerRadius: 20
                )
            )

            .shadow(
                color: .black.opacity(0.55),
                radius: 10,
                x: 0,
                y: 5
            )
        }
    }
}


// MARK: Preview

#Preview {

    NavigationStack {

        QuestCard(
            challenge: challengeData(
                day: 1,
                challengeText:
                    "Colorful Markets",
                challengeDetailSheet:
                    "Photograph a vibrant market stall with a variety of colorful goods and lively atmosphere."
            ),

            trip: TripPreferences(
                country: "Italy",
                startDate: Date(),
                endDate: Calendar.current.date(
                    byAdding: .day,
                    value: 3,
                    to: Date()
                )!,
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
