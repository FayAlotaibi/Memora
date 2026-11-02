//
//  CustomTabView.swift
//  QVoyage
//

import SwiftUI

struct CustomTabView: View {

    // MARK: - Selected Tab

    @State private var selectedTab: Int


    // MARK: - Trip

    @Bindable var trip: TripPreferences


    // MARK: - Init

    init(
        trip: TripPreferences,
        selectedTab: Int = 0
    ) {

        self.trip = trip

        _selectedTab = State(
            initialValue: selectedTab
        )
    }


    // MARK: - Body

    var body: some View {

        Group {

            if selectedTab == 0 {

                // MARK: Quest

                SwiftUIViewMain(
                    trip: trip
                )

            } else {

                // MARK: Journals

                Journals()
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background(
            Color("Backgroundcolor")
                .ignoresSafeArea()
        )

        // MARK: - Fixed Custom Tab Bar

        .overlay(
            alignment: .bottom
        ) {

            HStack(
                spacing: 0
            ) {

                // MARK: Quest

                TabButton(
                    icon:
                        "exclamationmark.warninglight",

                    title:
                        "Quest",

                    isSelected:
                        selectedTab == 0,

                    goldColor:
                        Color("buttoncolor"),

                    textColor:
                        Color("FontColor")
                ) {

                    withAnimation(
                        .easeInOut(
                            duration: 0.2
                        )
                    ) {

                        selectedTab = 0
                    }
                }


                // MARK: Journals

                TabButton(
                    icon:
                        "apple.books.pages",

                    title:
                        "Journals",

                    isSelected:
                        selectedTab == 1,

                    goldColor:
                        Color("buttoncolor"),

                    textColor:
                        Color("FontColor")
                ) {

                    withAnimation(
                        .easeInOut(
                            duration: 0.2
                        )
                    ) {

                        selectedTab = 1
                    }
                }
            }

            // MARK: Tab Bar Size

            .frame(
                width: 360,
                height: 70
            )

            // MARK: Inner Padding

            .padding(
                .horizontal,
                6
            )

            .padding(
                .vertical,
                5
            )

            // MARK: Background

            .background(
                Color("Backgroundcolor")
            )

            // MARK: Shape

            .clipShape(
                RoundedRectangle(
                    cornerRadius: 70
                )
            )

            // MARK: Shadow

            .shadow(
                color:
                    .black.opacity(
                        0.20
                    ),
                radius: 10,
                x: 0,
                y: 5
            )

            // MARK: Outer Horizontal Padding

            .padding(
                .horizontal,
                16
            )

            // MARK: Fixed Bottom Position

            .padding(
                .bottom,
                -15
            )
        }

        .navigationBarBackButtonHidden(
            true
        )
    }
}


// MARK: - Tab Button

struct TabButton: View {

    let icon: String
    let title: String
    let isSelected: Bool

    let goldColor: Color
    let textColor: Color

    let action: () -> Void


    var body: some View {

        Button {

            action()

        } label: {

            VStack(
                spacing: -5
            ) {

                Image(
                    systemName: icon
                )
                .font(
                    .system(
                        size: 27
                    )
                )
                .bold()


                Text(
                    title
                )
                .font(
                    .system(
                        size: 18
                    )
                )
                .bold()
            }
            .foregroundStyle(
                textColor
            )
            .frame(
                maxWidth: .infinity
            )
            .padding(
                .vertical,
                10
            )
            .background {

                if isSelected {

                    RoundedRectangle(
                        cornerRadius: 70
                    )
                    .fill(
                        goldColor
                            .opacity(
                                0.15
                            )
                    )
                }
            }
        }
        .buttonStyle(
            .plain
        )
    }
}


// MARK: - Preview

#Preview {

    NavigationStack {

        CustomTabView(

            trip:
                TripPreferences(

                    country:
                        "Spain",

                    startDate:
                        Calendar.current.date(
                            byAdding:
                                .day,
                            value:
                                -2,
                            to:
                                Date()
                        )!,

                    endDate:
                        Calendar.current.date(
                            byAdding:
                                .day,
                            value:
                                3,
                            to:
                                Date()
                        )!,

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

            selectedTab: 1
        )
    }
}
