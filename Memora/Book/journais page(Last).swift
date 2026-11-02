import SwiftUI
import SwiftData

struct JournalsPageLast: View {

    @Bindable var trip: TripPreferences

    var body: some View {

        ZStack {

            Color("Backgroundcolor")
                .ignoresSafeArea()

            VStack {

                Text("Journey Memories")
                    .font(
                        .system(
                            size: 32,
                            weight: .bold,
                            design: .serif
                        )
                    )
                    .foregroundStyle(
                        Color("FontColor")
                    )

                Text(trip.country)
                    .font(
                        .system(
                            size: 22,
                            weight: .bold,
                            design: .serif
                        )
                    )
                    .foregroundStyle(
                        Color("buttoncolor")
                    )
            }
        }
        .toolbar(
            .hidden,
            for: .navigationBar
        )
    }
}
