//
//  SwiftUIViewMain.swift
//  Memora
//

import SwiftUI
import SwiftData


// MARK: - Preference Key

struct DayPositionPreferenceKey: PreferenceKey {

    static var defaultValue: [Int: CGFloat] = [:]

    static func reduce(
        value: inout [Int: CGFloat],
        nextValue: () -> [Int: CGFloat]
    ) {
        value.merge(nextValue()) { $1 }
    }
}


// MARK: - Main View

struct SwiftUIViewMain: View {

    // MARK: - Trip

    @Bindable var trip: TripPreferences


    // MARK: - State

    @State private var selectedDay: Int = 1

    @State private var dayPositions: [Int: CGFloat] = [:]


    // MARK: - Responsive Sizes

    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    private var isSmall: Bool {
        screenWidth < 390
    }

    private var isLarge: Bool {
        screenWidth > 430
    }


    // MARK: - Trip Challenges

    /*
     نستخدم فقط Challenges التابعة لهذه الرحلة.

     هذا مهم حتى لا تختلط Challenges
     الخاصة برحلات قديمة مع الرحلة الحالية.
     */

    private var challenges: [challengeData] {

        trip.challenges.sorted {
            $0.day < $1.day
        }
    }


    // MARK: - Number Of Days

    private var numberOfDays: Int {

        guard
            let startDate = trip.startDate,
            let endDate = trip.endDate
        else {

            return max(
                1,
                challenges.count
            )
        }


        let calendar = Calendar.current


        let start =
            calendar.startOfDay(
                for: startDate
            )


        let end =
            calendar.startOfDay(
                for: endDate
            )


        let difference =
            calendar.dateComponents(
                [.day],
                from: start,
                to: end
            ).day ?? 0


        return max(
            1,
            difference + 1
        )
    }


    // MARK: - Current Day

    /*
     أول Challenge غير مكتمل
     يعتبر هو اليوم الحالي.

     مثال:

     Day 1 = completed
     Day 2 = not completed

     currentDay = 2
     */

    private var currentDay: Int {

        for day in 1...numberOfDays {

            if let challenge =
                challenges.first(
                    where: {
                        $0.day == day
                    }
                ) {

                if !challenge.isCompleted {
                    return day
                }

            } else {

                return day
            }
        }


        /*
         إذا كل الأيام مكتملة
         نبقى على آخر يوم.
         */

        return numberOfDays
    }


    // MARK: - Trip Completed

    /*
     هذا هو مصدر الحقيقة الوحيد.

     الرحلة تعتبر مكتملة إذا:

     1. يوجد Challenges
     2. يوجد Challenge لكل يوم
     3. كل Challenge مكتمل

     لا نستخدم trip.isCompleted.
     */

    private var tripIsCompleted: Bool {

        // لا تعتبر الرحلة مكتملة بدون Challenges

        guard !challenges.isEmpty else {
            return false
        }


        // لازم يكون عندنا Challenge لكل يوم

        guard challenges.count >= numberOfDays else {
            return false
        }


        // نفحص كل يوم

        for day in 1...numberOfDays {

            guard let challenge =
                challenges.first(
                    where: {
                        $0.day == day
                    }
                )
            else {

                return false
            }


            if !challenge.isCompleted {
                return false
            }
        }


        return true
    }


    // MARK: - Current Challenge

    private var currentChallenge: challengeData? {

        challenges.first {
            $0.day == currentDay
        }
    }


    // MARK: - Body

    var body: some View {

        Group {

            // MARK: Journey Finished

            if tripIsCompleted {

                TripFinishedView(
                    trip: trip
                )

            } else {

                journeyView
            }
        }


        // MARK: - Initial Day

        .onAppear {

            selectedDay =
                currentDay


            print(
                "========== MAIN PAGE =========="
            )

            print(
                "Trip:",
                trip.country
            )

            print(
                "Current Day:",
                currentDay
            )

            print(
                "Total Days:",
                numberOfDays
            )

            print(
                "Challenges:",
                challenges.count
            )


            for challenge in challenges {

                print(
                    "Day \(challenge.day) - Completed:",
                    challenge.isCompleted
                )
            }


            print(
                "Trip Completed:",
                tripIsCompleted
            )


            print(
                "==============================="
            )
        }


        // MARK: - Challenge Changes

        .onChange(
            of: challenges.map {
                "\($0.day)-\($0.isCompleted)"
            }
        ) { _, _ in

            /*
             عندما ينتهي Quest:

             challenge.isCompleted = true

             SwiftUI يعيد حساب:

             currentDay
             tripIsCompleted
             */

            withAnimation(
                .easeInOut(
                    duration: 0.5
                )
            ) {

                selectedDay =
                    currentDay
            }


            print(
                "➡️ Current Day Updated To:",
                currentDay
            )


            print(
                "Trip Completed:",
                tripIsCompleted
            )
        }
    }


    // MARK: - Journey View

    private var journeyView: some View {

        ZStack {

            // MARK: Background

            Color("Backgroundcolor")
                .ignoresSafeArea()


            VStack(
                spacing: -210
            ) {

                // MARK: Header

                Text(
                    "Your Journey\none day at a time!"
                )
                .font(
                    .system(
                        size:
                            isSmall
                            ? 24
                            : (
                                isLarge
                                ? 30
                                : 27
                            ),

                        weight: .bold,
                        design: .serif
                    )
                )
                .foregroundStyle(
                    Color("FontColor")
                )
                .offset(
                    x: 9,
                    y: 14
                )


                // MARK: Header Line

                Image("Line2")
                    .padding(
                        .leading,
                        isSmall
                        ? 55
                        : 90
                    )
                    .offset(
                        x: 9,
                        y: 14
                    )


                // MARK: - Days Scroll

                ScrollView(
                    .horizontal,
                    showsIndicators: false
                ) {

                    ZStack(
                        alignment: .leading
                    ) {

                        // MARK: Timeline

                        Capsule()
                            .fill(
                                Color("FontColor")
                            )
                            .frame(
                                height: 4
                            )
                            .padding(
                                .horizontal,
                                isSmall
                                ? 165
                                : 220
                            )
                            .offset(
                                x: -12,
                                y: 80
                            )


                        // MARK: Days

                        HStack(
                            spacing: 28
                        ) {

                            ForEach(
                                1...numberOfDays,
                                id: \.self
                            ) { dayNumber in

                                if let challenge =
                                    challenges.first(
                                        where: {
                                            $0.day ==
                                                dayNumber
                                        }
                                    ) {

                                    DayView(
                                        day: challenge
                                    )

                                    // Future days lighter

                                    .opacity(
                                        dayNumber <= currentDay
                                        ? 1.0
                                        : 0.45
                                    )

                                    .onTapGesture {

                                        // لا نفتح يوم مستقبلي

                                        guard
                                            dayNumber <=
                                                currentDay
                                        else {

                                            return
                                        }


                                        withAnimation(
                                            .easeInOut(
                                                duration: 0.5
                                            )
                                        ) {

                                            selectedDay =
                                                dayNumber
                                        }
                                    }

                                    .background {

                                        GeometryReader {
                                            itemGeo in

                                            Color.clear
                                                .preference(
                                                    key:
                                                        DayPositionPreferenceKey.self,

                                                    value: [

                                                        dayNumber:

                                                            itemGeo
                                                                .frame(
                                                                    in:
                                                                        .named(
                                                                            "scrollContent"
                                                                        )
                                                                )
                                                                .midX
                                                    ]
                                                )
                                        }
                                    }

                                } else {

                                    // MARK: Future Day

                                    FutureDayView(
                                        day: dayNumber
                                    )

                                    .background {

                                        GeometryReader {
                                            itemGeo in

                                            Color.clear
                                                .preference(
                                                    key:
                                                        DayPositionPreferenceKey.self,

                                                    value: [

                                                        dayNumber:

                                                            itemGeo
                                                                .frame(
                                                                    in:
                                                                        .named(
                                                                            "scrollContent"
                                                                        )
                                                                )
                                                                .midX
                                                    ]
                                                )
                                        }
                                    }
                                }
                            }
                        }
                        .padding(
                            .horizontal,
                            isSmall
                            ? 165
                            : 220
                        )


                        // MARK: Character With Bag

                        Image(
                            "CharacterWithBag"
                        )
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width:
                                isSmall
                                ? 120
                                : 150,

                            height:
                                isSmall
                                ? 120
                                : 150
                        )
                        .position(
                            x:
                                dayPositions[
                                    currentDay
                                ]
                                ?? 0,

                            y:
                                isSmall
                                ? 120
                                : 139
                        )
                        .animation(
                            .easeInOut(
                                duration: 0.5
                            ),
                            value:
                                currentDay
                        )
                        .zIndex(1)
                    }

                    .coordinateSpace(
                        name: "scrollContent"
                    )

                    .onPreferenceChange(
                        DayPositionPreferenceKey.self
                    ) { positions in

                        dayPositions =
                            positions
                    }

                    .frame(
                        height: 170
                    )
                }


                // MARK: - Current Day Section

                VStack {

                    Text(
                        "Day \(currentDay)"
                    )
                    .font(
                        .system(
                            size:
                                isSmall
                                ? 30
                                : 35,

                            weight: .bold,
                            design: .serif
                        )
                    )
                    .padding(
                        .trailing,
                        isSmall
                        ? 55
                        : 90
                    )
                    .padding(
                        .top,
                        isSmall
                        ? 180
                        : 230
                    )
                    .foregroundStyle(
                        Color("FontColor")
                    )


                    // MARK: - Quest Card

                    ZStack(
                        alignment: .topTrailing
                    ) {

                        if let currentChallenge {

                            QuestCard(
                                challenge:
                                    currentChallenge,

                                trip:
                                    trip
                            )

                        } else {

                            // MARK: Loading Card

                            RoundedRectangle(
                                cornerRadius: 20
                            )
                            .fill(
                                Color(
                                    "Backgroundcolor"
                                )
                            )
                            .frame(
                                width:
                                    isSmall
                                    ? 320
                                    : 380,

                                height:
                                    170
                            )
                            .overlay {

                                VStack(
                                    spacing: 8
                                ) {

                                    ProgressView()
                                        .tint(
                                            Color(
                                                "buttoncolor"
                                            )
                                        )


                                    Text(
                                        "Your quest is being prepared..."
                                    )
                                    .font(
                                        .system(
                                            size: 16,
                                            design: .serif
                                        )
                                    )
                                    .foregroundStyle(
                                        Color(
                                            "FontColor"
                                        )
                                    )
                                }
                            }
                            .overlay {

                                RoundedRectangle(
                                    cornerRadius: 20
                                )
                                .stroke(
                                    .black,
                                    lineWidth: 3
                                )
                            }
                        }


                        // MARK: Character With Camera

                        Image(
                            "charecterWithCamera"
                        )
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 200
                        )
                        .offset(
                            x:
                                isSmall
                                ? 70
                                : -100,

                            y:
                                isSmall
                                ? -220
                                : -100
                        )
                        .allowsHitTesting(
                            false
                        )
                    }
                    .padding(
                        .trailing,
                        isSmall
                        ? -90
                        : -170
                    )
                    .padding(
                        .top,
                        10
                    )
                }


                Spacer()
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .offset(
                x:
                    isSmall
                    ? -45
                    : -83
            )
            .offset(
                y: 5
            )
        }
    }
}


// MARK: - Future Day View

struct FutureDayView: View {

    let day: Int


    var body: some View {

        VStack(
            spacing: 8
        ) {

            Circle()
                .fill(
                    Color(
                        "Backgroundcolor"
                    )
                )
                .frame(
                    width: 70,
                    height: 70
                )
                .overlay {

                    Circle()
                        .stroke(
                            Color(
                                "FontColor"
                            )
                            .opacity(
                                0.35
                            ),
                            lineWidth: 2
                        )
                }
                .overlay {

                    Image(
                        systemName:
                            "lock.fill"
                    )
                    .foregroundStyle(
                        Color(
                            "FontColor"
                        )
                        .opacity(
                            0.45
                        )
                    )
                    .font(
                        .system(
                            size: 18
                        )
                    )
                }


            Text(
                "Day \(day)"
            )
            .font(
                .system(
                    size: 14,
                    weight: .medium,
                    design: .serif
                )
            )
            .foregroundStyle(
                Color(
                    "FontColor"
                )
                .opacity(
                    0.45
                )
            )
        }
        .frame(
            width: 80
        )
    }
}


// MARK: - Preview

#Preview {

    NavigationStack {

        SwiftUIViewMain(

            trip:
                TripPreferences(

                    country:
                        "Italy",

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
                )
        )
    }
}
