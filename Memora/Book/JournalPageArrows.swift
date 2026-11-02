//
//  JournalPageArrows.swift
//  Memora
//
//  Created by وتين الرميح on 02/03/1448 AH.
//

import SwiftUI

struct JournalPageArrows: View {

    let showNextButton: Bool
    let nextPage: AnyView

    @Environment(\.dismiss)
    private var dismiss


    init<NextPage: View>(
        showNextButton: Bool = true,
        @ViewBuilder nextPage: () -> NextPage
    ) {
        self.showNextButton = showNextButton
        self.nextPage = AnyView(nextPage())
    }


    var body: some View {

        HStack {

            // MARK: - Previous

            Button {

                dismiss()

            } label: {

                Image(systemName: "chevron.left")
                    .font(
                        .system(
                            size: 30,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(.white)
                    .frame(
                        width: 55,
                        height: 80
                    )
                    .background(
                        Color.black.opacity(0.25)
                    )
                    .clipShape(
                        Capsule()
                    )
            }
            .buttonStyle(.plain)


            Spacer()


            // MARK: - Next

            if showNextButton {

                NavigationLink {

                    nextPage

                } label: {

                    Image(systemName: "chevron.right")
                        .font(
                            .system(
                                size: 30,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(.white)
                        .frame(
                            width: 55,
                            height: 80
                        )
                        .background(
                            Color.black.opacity(0.25)
                        )
                        .clipShape(
                            Capsule()
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(
            .horizontal,
            5
        )
    }
}
