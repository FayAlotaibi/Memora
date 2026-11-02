import SwiftUI
import SwiftData
import UIKit

struct DayDetailSheet: View {

    @Bindable var challenge: challengeData

    @Environment(\.dismiss)
    private var dismiss

    var body: some View {

        VStack(spacing: 0) {

            // MARK: Drag Indicator

            Capsule()
                .fill(.gray.opacity(0.4))
                .frame(width: 55, height: 5)
                .padding(.top, 10)


            // MARK: Close Button

            HStack {

                Button {

                    dismiss()

                } label: {

                    Image(systemName: "xmark")
                        .font(
                            .system(
                                size: 20,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(.white)
                        .frame(
                            width: 48,
                            height: 48
                        )
                        .background(
                            Color("buttoncolor")
                        )
                        .clipShape(Circle())
                }

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 12)


            ScrollView(showsIndicators: false) {

                VStack(spacing: 24) {

                    // MARK: Day

                    Text("Day \(challenge.day)")
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


                    // MARK: Challenge

                    Text(challenge.challengeText)
                        .font(
                            .system(
                                size: 20,
                                weight: .medium,
                                design: .serif
                            )
                        )
                        .foregroundStyle(
                            Color("FontColor")
                        )
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)


                    // MARK: Image

                    if let imageData = challenge.imageData,
                       let image = UIImage(data: imageData) {

                        GeometryReader { geometry in

                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: geometry.size.width,
                                    height: 290
                                )
                                .clipped()
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 28
                                    )
                                )
                                .overlay {
                                    RoundedRectangle(
                                        cornerRadius: 28
                                    )
                                    .stroke(
                                        .white,
                                        lineWidth: 4
                                    )
                                }
                                .shadow(
                                    color: .black.opacity(0.15),
                                    radius: 12,
                                    y: 6
                                )
                        }
                        .frame(height: 290)

                    } else {

                        RoundedRectangle(
                            cornerRadius: 28
                        )
                        .fill(
                            Color("buttoncolor")
                                .opacity(0.12)
                        )
                        .frame(height: 290)
                        .overlay {

                            VStack(spacing: 12) {

                                Image(
                                    systemName: "photo"
                                )
                                .font(
                                    .system(size: 45)
                                )
                                .foregroundStyle(
                                    Color("FontColor")
                                        .opacity(0.5)
                                )

                                Text("No photo yet")
                                    .font(
                                        .system(
                                            size: 18,
                                            design: .serif
                                        )
                                    )
                                    .foregroundStyle(
                                        Color("FontColor")
                                    )
                            }
                        }
                    }


                    // MARK: Note

                    VStack(
                        alignment: .leading,
                        spacing: 16
                    ) {

                        Label {

                            Text("Your Note")
                                .font(
                                    .system(
                                        size: 20,
                                        weight: .bold,
                                        design: .serif
                                    )
                                )

                        } icon: {

                            Image(
                                systemName: "note.text"
                            )
                            .foregroundStyle(
                                Color("buttoncolor")
                            )
                        }
                        .foregroundStyle(
                            Color("FontColor")
                        )


                        if challenge.note.isEmpty {

                            Text("No note added.")
                                .font(
                                    .system(
                                        size: 17,
                                        weight: .medium,
                                        design: .serif
                                    )
                                )
                                .foregroundStyle(
                                    Color("FontColor")
                                        .opacity(0.5)
                                )

                        } else {

                            Text(challenge.note)
                                .font(
                                    .system(
                                        size: 17,
                                        weight: .medium,
                                        design: .serif
                                    )
                                )
                                .foregroundStyle(
                                    Color("FontColor")
                                )
                                .fixedSize(
                                    horizontal: false,
                                    vertical: true
                                )
                        }
                    }
                    .padding(22)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .background(
                        RoundedRectangle(
                            cornerRadius: 22
                        )
                        .fill(
                            Color("buttoncolor")
                                .opacity(0.15)
                        )
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 22
                        )
                        .stroke(
                            Color("buttoncolor")
                                .opacity(0.25),
                            lineWidth: 1
                        )
                    )

                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .background(
            Color("Backgroundcolor")
        )
        .presentationDetents([.large])
        .presentationDragIndicator(.hidden)
    }
}
