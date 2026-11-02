//
//  Journals.swift
//  QVoyage
//

import SwiftUI
import SwiftData
import UIKit

struct Journals: View {

    // MARK: - SwiftData

    @Query(
        sort: \TripPreferences.startDate,
        order: .reverse
    )
    private var trips: [TripPreferences]


    // MARK: - Navigation

    @State private var selectedTrip: TripPreferences?

    @State private var openJourney = false


    // MARK: - Colors

    private let backgroundColor = Color(
        red: 1.0,
        green: 0.9725,
        blue: 0.9412
    )

    private let goldColor = Color(
        red: 0.8314,
        green: 0.6275,
        blue: 0.0902
    )


    // MARK: - Layout

    private let rowHeight: CGFloat = 240


    // MARK: - Completed Trips

    /*
     مهم:

     لا نعتمد على:
     
         trip.isCompleted

     لتحديد إذا الرحلة انتهت.

     نعتبر الرحلة مكتملة إذا:

     1. يوجد فيها Challenges.
     2. جميع الـ Challenges فيها
        isCompleted == true

     بهذه الطريقة يكون مصدر الحقيقة
     هو نفس الـ Challenges.
     */

    private var completedTrips: [TripPreferences] {

        trips.filter { trip in

            // لازم الرحلة يكون فيها تحديات
            guard !trip.challenges.isEmpty else {
                return false
            }

            // كل التحديات لازم تكون مكتملة
            return trip.challenges.allSatisfy { challenge in
                challenge.isCompleted
            }
        }
    }


    // MARK: - Body

    var body: some View {

        ZStack {

            backgroundColor
                .ignoresSafeArea()


            VStack(
                alignment: .leading,
                spacing: -190
            ) {

                // MARK: Header

                VStack(
                    alignment: .leading,
                    spacing: -210
                ) {

                    Text("My Journeys")
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
                        .padding(
                            .leading,
                            5
                        )


                    Image("Line2")
                        .padding(
                            .leading,
                            -160
                        )
                }


                // MARK: Timeline

                GeometryReader { geo in

                    let centerX =
                        geo.size.width * 0.50


                    ScrollView(
                        showsIndicators: false
                    ) {

                        ZStack {

                            // MARK: Journey Path

                            if !completedTrips.isEmpty {

                                JourneyPath(
                                    journeyCount:
                                        completedTrips.count,

                                    rowHeight:
                                        rowHeight
                                )
                                .stroke(
                                    goldColor,
                                    style:
                                        StrokeStyle(
                                            lineWidth: 4,
                                            lineCap: .round,
                                            dash: [
                                                12,
                                                12
                                            ]
                                        )
                                )
                                .allowsHitTesting(false)
                            }


                            // MARK: Journey Cards

                            ForEach(
                                completedTrips.indices,
                                id: \.self
                            ) { index in

                                let trip =
                                    completedTrips[index]


                                let y =
                                    CGFloat(index)
                                    * rowHeight
                                    + 60


                                let isRight =
                                    index % 2 == 1


                                Button {

                                    selectedTrip =
                                        trip

                                    openJourney =
                                        true

                                } label: {

                                    JourneyCard(
                                        trip: trip,
                                        isRight: isRight
                                    )
                                    .contentShape(
                                        Rectangle()
                                    )
                                }
                                .buttonStyle(
                                    .plain
                                )
                                .contentShape(
                                    Rectangle()
                                )
                                .frame(
                                    width:
                                        geo.size.width
                                )
                                .position(
                                    x:
                                        centerX,
                                    y:
                                        y
                                )
                                .zIndex(5)
                            }


                            // MARK: Empty State

                            if completedTrips.isEmpty {

                                VStack(
                                    spacing: 15
                                ) {

                                    Image(
                                        systemName:
                                            "book.closed"
                                    )
                                    .font(
                                        .system(
                                            size: 45
                                        )
                                    )
                                    .foregroundStyle(
                                        Color(
                                            "buttoncolor"
                                        )
                                    )


                                    Text(
                                        "No journeys yet"
                                    )
                                    .font(
                                        .system(
                                            size: 24,
                                            weight: .bold,
                                            design: .serif
                                        )
                                    )
                                    .foregroundStyle(
                                        Color(
                                            "FontColor"
                                        )
                                    )


                                    Text(
                                        """
                                        Complete a journey
                                        and your memories will appear here.
                                        """
                                    )
                                    .font(
                                        .system(
                                            size: 16,
                                            design: .serif
                                        )
                                    )
                                    .multilineTextAlignment(
                                        .center
                                    )
                                    .foregroundStyle(
                                        Color(
                                            "FontColor"
                                        )
                                        .opacity(
                                            0.7
                                        )
                                    )
                                }
                                .frame(
                                    width:
                                        geo.size.width
                                )
                                .position(
                                    x:
                                        centerX,
                                    y:
                                        250
                                )
                            }
                        }
                        .frame(
                            width:
                                geo.size.width,

                            height:
                                max(
                                    400,

                                    CGFloat(
                                        completedTrips.count
                                    )
                                    * rowHeight
                                    + 120
                                )
                        )
                    }
                }
            }
        }


        // MARK: Open Journey

        .navigationDestination(
            isPresented:
                $openJourney
        ) {

            if let selectedTrip {

                journals_page_Main_(
                    trip:
                        selectedTrip
                )
                .navigationBarBackButtonHidden(
                    true
                )

            } else {

                EmptyView()
            }
        }


        // MARK: Debug

        .onAppear {

            print(
                "========== JOURNALS =========="
            )

            print(
                "Total trips:",
                trips.count
            )


            // Print every trip
            for trip in trips {

                print(
                    "========== TRIP =========="
                )

                print(
                    "Country:",
                    trip.country
                )

                print(
                    "Challenges:",
                    trip.challenges.count
                )


                // Sort challenges by day
                let sortedChallenges =
                    trip.challenges.sorted {
                        $0.day < $1.day
                    }


                // Print each challenge
                for challenge in sortedChallenges {

                    print(
                        "Day \(challenge.day) - Completed:",
                        challenge.isCompleted
                    )
                }


                // Calculate completion
                let completed =
                    !trip.challenges.isEmpty &&
                    trip.challenges.allSatisfy {
                        $0.isCompleted
                    }


                print(
                    "Trip Completed:",
                    completed
                )

                print(
                    "=========================="
                )
            }


            print(
                "Completed trips:",
                completedTrips.count
            )

            print(
                "=============================="
            )
        }
    }
}


// MARK: - Preview

#Preview {

    NavigationStack {

        Journals()
            .modelContainer(
                for: [
                    TripPreferences.self,
                    challengeData.self
                ],
                inMemory: true
            )
    }
}
