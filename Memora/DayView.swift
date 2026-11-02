import SwiftUI

struct DayView: View {

    let day: challengeData

    @State private var showSheet = false

    var body: some View {

        VStack(spacing: 10) {

            // MARK: Day Number

            Text("Day \(day.day)")
                .font(
                    .system(
                        size: 27,
                        weight: .bold,
                        design: .serif
                    )
                )
                .foregroundStyle(Color("FontColor"))


            // MARK: Day Image

            if let imageData = day.imageData,
               let uiImage = UIImage(data: imageData) {

                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .contentShape(Circle())
                    .onTapGesture {
                        showSheet = true
                    }

            } else {

                ZStack {

                    Circle()
                        .fill(
                            Color(red: 238/255,
                                  green: 231/255,
                                  blue: 205/255)
                        )
                        .frame(width: 100, height: 100)

                    VStack(spacing: 5) {

                        Image(systemName: "photo")
                            .font(.system(size: 25))
                            .foregroundStyle(.white)

                        Text("not yet")
                            .font(
                                .system(
                                    size: 13,
                                    weight: .medium,
                                    design: .serif
                                )
                            )
                            .foregroundStyle(Color("FontColor"))
                    }
                }
            }
        }

        // MARK: Day Detail Sheet

        .sheet(isPresented: $showSheet) {

            DayDetailSheet(
                challenge: day
            )
        }
    }
}
