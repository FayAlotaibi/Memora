//
//  JournalHeader.swift
//  Memora
//

//import SwiftUI
//
//struct JournalHeader: View {
//
//    let country: String
//    let showNextButton: Bool
//    let nextPage: AnyView
//
//    @Environment(\.dismiss)
//    private var dismiss
//
//
//    init<NextPage: View>(
//        country: String,
//        showNextButton: Bool = true,
//        @ViewBuilder nextPage: () -> NextPage
//    ) {
//
//        self.country = country
//        self.showNextButton = showNextButton
//        self.nextPage = AnyView(nextPage())
//    }
//
//
//    var body: some View {
//
//        VStack(
//            alignment: .leading,
//            spacing: 0
//        ) {
//
//            // MARK: Navigation Buttons
//
//            HStack {
//
//                // MARK: Back
//
//                Button {
//
//                    dismiss()
//
//                } label: {
//
//                    Image(
//                        systemName: "chevron.left"
//                    )
//                    .font(
//                        .system(
//                            size: 20,
//                            weight: .bold
//                        )
//                    )
//                    .foregroundStyle(.white)
//                    .frame(
//                        width: 55,
//                        height: 55
//                    )
//                    .background(
//                        Color("buttoncolor")
//                    )
//                    .clipShape(
//                        Circle()
//                    )
//                    .shadow(
//                        color: .black.opacity(0.15),
//                        radius: 5,
//                        x: 0,
//                        y: 3
//                    )
//                }
//                .buttonStyle(.plain)
//
//
//                Spacer()
//
//
//                // MARK: Next
//
//                if showNextButton {
//
//                    NavigationLink {
//
//                        nextPage
//
//                    } label: {
//
//                        Image(
//                            systemName: "chevron.right"
//                        )
//                        .font(
//                            .system(
//                                size: 20,
//                                weight: .bold
//                            )
//                        )
//                        .foregroundStyle(.white)
//                        .frame(
//                            width: 55,
//                            height: 55
//                        )
//                        .background(
//                            Color("buttoncolor")
//                        )
//                        .clipShape(
//                            Circle()
//                        )
//                        .shadow(
//                            color: .black.opacity(0.15),
//                            radius: 5,
//                            x: 0,
//                            y: 3
//                        )
//                    }
//                    .buttonStyle(.plain)
//
//                } else {
//
//                    Color.clear
//                        .frame(
//                            width: 55,
//                            height: 55
//                        )
//                }
//            }
//            .padding(
//                .horizontal,
//                25
//            )
//            .padding(
//                .top,
//                8
//            )
//
//
//            // MARK: Country
//
//            Text(country)
//                .font(
//                    .system(
//                        size: 33,
//                        weight: .bold,
//                        design: .serif
//                    )
//                )
//                .foregroundStyle(
//                    Color("FontColor")
//                )
//                .frame(
//                    maxWidth: .infinity,
//                    alignment: .leading
//                )
//                .padding(
//                    .horizontal,
//                    25
//                )
//                .padding(
//                    .top,
//                    20
//                )
//
//
//            // MARK: Divider
//
//            Rectangle()
//                .fill(
//                    Color.gray.opacity(0.18)
//                )
//                .frame(
//                    height: 2
//                )
//                .padding(
//                    .horizontal,
//                    25
//                )
//                .padding(
//                    .top,
//                    7
//                )
//        }
//    }
//}
import SwiftUI

struct JournalHeader: View {

    let country: String
    let showNextButton: Bool
    let nextPage: AnyView

    @Environment(\.dismiss)
    private var dismiss

    @State private var goToNextPage = false


    init<NextPage: View>(
        country: String,
        showNextButton: Bool = true,
        @ViewBuilder nextPage: () -> NextPage
    ) {

        self.country = country
        self.showNextButton = showNextButton
        self.nextPage = AnyView(nextPage())
    }


    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 0
        ) {

            // MARK: - Navigation Buttons

            HStack {

                // MARK: Back

                Button {

                    dismiss()

                } label: {

                    Image(
                        systemName: "chevron.left"
                    )
                    .font(
                        .system(
                            size: 20,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(.white)
                    .frame(
                        width: 55,
                        height: 55
                    )
                    .background(
                        Color("buttoncolor")
                    )
                    .clipShape(
                        Circle()
                    )
                    .shadow(
                        color: .black.opacity(0.15),
                        radius: 5,
                        x: 0,
                        y: 3
                    )
                }
                .buttonStyle(.plain)


                Spacer()


                // MARK: Next

                if showNextButton {

                    Button {

                        goToNextPage = true

                    } label: {

                        Image(
                            systemName: "chevron.right"
                        )
                        .font(
                            .system(
                                size: 20,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(.white)
                        .frame(
                            width: 55,
                            height: 55
                        )
                        .background(
                            Color("buttoncolor")
                        )
                        .clipShape(
                            Circle()
                        )
                        .shadow(
                            color: .black.opacity(0.15),
                            radius: 5,
                            x: 0,
                            y: 3
                        )
                    }
                    .buttonStyle(.plain)

                } else {

                    Color.clear
                        .frame(
                            width: 55,
                            height: 55
                        )
                }
            }
            .padding(
                .horizontal,
                25
            )
            .padding(
                .top,
                8
            )


            // MARK: - Country

            Text(country)
                .font(
                    .system(
                        size: 33,
                        weight: .bold,
                        design: .serif
                    )
                )
                .foregroundStyle(
                    Color("FontColor")
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(
                    .horizontal,
                    25
                )
                .padding(
                    .top,
                    20
                )


            // MARK: - Divider

            Rectangle()
                .fill(
                    Color.gray.opacity(0.18)
                )
                .frame(
                    height: 2
                )
                .padding(
                    .horizontal,
                    25
                )
                .padding(
                    .top,
                    7
                )
        }

        // MARK: - Swipe

        .gesture(
            DragGesture(
                minimumDistance: 50
            )
            .onEnded { value in

                let horizontalMovement =
                    value.translation.width

                // Swipe left → Next page

                if horizontalMovement < -80,
                   showNextButton {

                    goToNextPage = true
                }

                // Swipe right → Previous page

                else if horizontalMovement > 80 {

                    dismiss()
                }
            }
        )

        // MARK: - Next Page Navigation

        .navigationDestination(
            isPresented: $goToNextPage
        ) {

            nextPage
        }
    }
}
