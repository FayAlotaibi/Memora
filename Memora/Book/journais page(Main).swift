//
//  journals_page_Main_.swift
//  QVoyage
//

import SwiftUI
import SwiftData

struct journals_page_Main_: View {

    // MARK: - Trip

    @Bindable var trip: TripPreferences


    // MARK: - Navigation

    @State private var openJournal = false


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
                    showNextButton: false
                ) {

                    EmptyView()
                }


                Spacer()


                // MARK: - Closed Journal Cover

                Image("italyBook")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        maxWidth: 1000
                    )
                    .frame(
                        maxWidth: .infinity,
                        alignment: .center
                    )
                    .offset(
                        x: 15,
                        y: -35
                    )


                // MARK: - Open Journal Button

                Button {

                    openJournal = true

                } label: {

                    HStack(
                        spacing: 10
                    ) {

                        Text("Open Journal")

                        Image(
                            systemName: "book.pages"
                        )
                    }
                    .font(
                        .system(
                            size: 19,
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
                        height: 58
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
                    -35
                )


                Spacer()
            }
        }


        // MARK: - Open Journal Navigation

        .navigationDestination(
            isPresented:
                $openJournal
        ) {

            MyJourneyView(
                trip: trip
            )
            .navigationBarBackButtonHidden(
                true
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

        journals_page_Main_(

            trip:
                TripPreferences(

                    country:
                        "Italy",

                    startDate:
                        Calendar.current.date(
                            byAdding:
                                .month,
                            value:
                                -2,
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
