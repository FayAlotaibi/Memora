//
//  JourneyCard.swift
//  QVoyage
//

import SwiftUI
import SwiftData

struct JourneyCard: View {

    // MARK: - Trip

    @Bindable var trip: TripPreferences

    let isRight: Bool


    // MARK: - Colors

    private let primaryColor = Color(
        red: 0.1725,
        green: 0.2431,
        blue: 0.1804
    )

    private let goldColor = Color(
        red: 0.8314,
        green: 0.6275,
        blue: 0.0902
    )


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

        HStack {

            if isRight {

                Spacer(minLength: 60)

                details

                image

            } else {

                image

                details

                Spacer(minLength: 60)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
    }


    // MARK: - Image

    private var image: some View {

        Group {

            if let firstPhoto {

                Image(uiImage: firstPhoto)
                    .resizable()
                    .scaledToFill()

            } else {

                Image(
                    systemName: "photo"
                )
                .font(
                    .system(
                        size: 35
                    )
                )
                .foregroundStyle(
                    goldColor
                )
                .frame(
                    width: 110,
                    height: 110
                )
                .background(
                    Color("buttoncolor")
                        .opacity(0.12)
                )
            }
        }
        .frame(
            width: 110,
            height: 110
        )
        .clipShape(Circle())
        .overlay {

            Circle()
                .stroke(
                    .white,
                    lineWidth: 4
                )
        }
        .shadow(
            radius: 5
        )
    }


    // MARK: - Details

    private var details: some View {

        VStack(
            alignment: .leading,
            spacing: 6
        ) {

            HStack(spacing: 5) {

                Image(
                    systemName:
                        "mappin.and.ellipse"
                )
                .foregroundStyle(
                    goldColor
                )


                Text(trip.country)
                    .font(
                        .system(
                            size: 28,
                            weight: .bold,
                            design: .serif
                        )
                    )
                    .foregroundStyle(
                        primaryColor
                    )
            }


            Text(
                trip.travelWith ?? ""
            )
            .font(
                .system(
                    size: 17
                )
            )
            .foregroundStyle(
                primaryColor
            )


            Text(dateText)
                .font(
                    .system(
                        size: 15
                    )
                )
                .foregroundStyle(
                    .gray
                )
        }
    }
}
