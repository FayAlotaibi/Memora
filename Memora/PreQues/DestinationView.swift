//
//  DestinationView.swift
//  Memora
//

import SwiftUI
import MapKit
import Combine
import SwiftData


// MARK: - City Search Service

class CitySearchService:
    NSObject,
    ObservableObject,
    MKLocalSearchCompleterDelegate {

    @Published var results:
        [MKLocalSearchCompletion] = []

    private let completer =
        MKLocalSearchCompleter()


    override init() {

        super.init()

        completer.delegate = self
        completer.resultTypes = .address
    }


    func search(
        _ text: String
    ) {

        let cleanText =
            text.trimmingCharacters(
                in: .whitespaces
            )

        if cleanText.isEmpty {

            results = []
            return
        }

        completer.queryFragment =
            cleanText
    }


    func completerDidUpdateResults(
        _ completer:
            MKLocalSearchCompleter
    ) {

        DispatchQueue.main.async {

            self.results =
                Array(
                    completer
                        .results
                        .prefix(6)
                )
        }
    }


    func completer(
        _ completer:
            MKLocalSearchCompleter,
        didFailWithError error: Error
    ) {

        print(
            "Search error:",
            error.localizedDescription
        )
    }
}


// MARK: - Destination View

struct DestinationView: View {

    // MARK: SwiftData

    @Environment(\.modelContext)
    private var modelContext


    // MARK: Navigation

    @State private var savedTrip:
        TripPreferences?


    // MARK: Search

    @State private var searchText = ""

    @State private var selectedDestination = ""

    @State private var showSearchResults = false


    @StateObject
    private var citySearch =
        CitySearchService()


    // MARK: Popular Destinations

    let destinations = [

        ("London", "img1"),
        ("Spain", "img2"),
        ("France", "img3"),
        ("Japan", "img4"),
        ("Italy", "img5")
    ]


    // MARK: - Body

    var body: some View {

        ZStack {

            // MARK: Background

            Color("Backgroundcolor")
                .ignoresSafeArea()


            VStack(
                spacing: 0
            ) {

                // MARK: Progress Bar

                VStack(
                    spacing: 14
                ) {

                    HStack(
                        spacing: 0
                    ) {

                        ForEach(
                            0..<6
                        ) { index in

                            Circle()
                                .fill(
                                    index < 2
                                    ? Color("FontColor")
                                    : Color(
                                        red: 0.549,
                                        green: 0.667,
                                        blue: 0.565
                                    )
                                )
                                .frame(
                                    width: 10,
                                    height: 10
                                )


                            if index < 5 {

                                Rectangle()
                                    .fill(
                                        Color("FontColor")
                                    )
                                    .frame(
                                        height: 2
                                    )
                            }
                        }
                    }
                    .padding(
                        .horizontal,
                        35
                    )


                    Text(
                        "Step 2 of 6"
                    )
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
                .padding(
                    .top,
                    30
                )


                // MARK: Main Content

                ScrollView(
                    showsIndicators: false
                ) {

                    VStack(
                        alignment: .leading,
                        spacing: 16
                    ) {

                        // MARK: Title

                        Text(
                            "Where are you going?"
                        )
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
                        .lineLimit(1)
                        .minimumScaleFactor(
                            0.8
                        )


                        // MARK: Search Box

                        HStack {

                            TextField(
                                "Search destination",
                                text: $searchText
                            )
                            .font(
                                .system(
                                    size: 18,
                                    design: .serif
                                )
                            )
                            .foregroundStyle(
                                Color("FontColor")
                            )
                            .onChange(
                                of: searchText
                            ) { _, newValue in

                                citySearch.search(
                                    newValue
                                )

                                showSearchResults =
                                    !newValue.isEmpty
                            }


                            if !searchText.isEmpty {

                                Button {

                                    searchText = ""

                                    citySearch.results = []

                                    showSearchResults =
                                        false

                                } label: {

                                    Image(
                                        systemName:
                                            "xmark.circle.fill"
                                    )
                                    .font(
                                        .system(
                                            size: 22
                                        )
                                    )
                                    .foregroundStyle(
                                        Color.gray
                                    )
                                }

                            } else {

                                Image(
                                    systemName:
                                        "magnifyingglass"
                                )
                                .font(
                                    .system(
                                        size: 24
                                    )
                                )
                                .foregroundStyle(
                                    Color("FontColor")
                                )
                            }
                        }
                        .padding(
                            .horizontal,
                            20
                        )
                        .frame(
                            height: 64
                        )
                        .background(
                            Color(
                                red: 0.961,
                                green: 0.929,
                                blue: 0.890
                            )
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 32
                            )
                        )
                        .overlay {

                            RoundedRectangle(
                                cornerRadius: 32
                            )
                            .stroke(
                                Color(
                                    red: 0.882,
                                    green: 0.831,
                                    blue: 0.769
                                ),
                                lineWidth: 1
                            )
                        }
                        .shadow(
                            color:
                                .black.opacity(
                                    0.18
                                ),
                            radius: 4,
                            x: 0,
                            y: 4
                        )


                        // MARK: Search Results

                        if showSearchResults &&
                            !searchText.isEmpty {

                            Text(
                                "Search results"
                            )
                            .font(
                                .system(
                                    size: 25,
                                    weight: .semibold,
                                    design: .serif
                                )
                            )
                            .foregroundStyle(
                                Color("FontColor")
                            )


                            VStack(
                                spacing: 11
                            ) {

                                if citySearch
                                    .results
                                    .isEmpty {

                                    HStack(
                                        spacing: 12
                                    ) {

                                        ProgressView()
                                            .tint(
                                                Color(
                                                    "buttoncolor"
                                                )
                                            )

                                        Text(
                                            "Searching..."
                                        )
                                        .font(
                                            .system(
                                                size: 17,
                                                design: .serif
                                            )
                                        )
                                        .foregroundStyle(
                                            Color("FontColor")
                                        )

                                        Spacer()
                                    }
                                    .padding(
                                        .horizontal,
                                        10
                                    )
                                    .frame(
                                        height: 65
                                    )

                                } else {

                                    ForEach(
                                        citySearch.results,
                                        id: \.self
                                    ) { result in

                                        Button {

                                            selectedDestination =
                                                result.title

                                            searchText = ""

                                            showSearchResults =
                                                false

                                            citySearch.results =
                                                []

                                        } label: {

                                            HStack(
                                                spacing: 14
                                            ) {

                                                ZStack {

                                                    Circle()
                                                        .fill(
                                                            Color(
                                                                "buttoncolor"
                                                            )
                                                            .opacity(
                                                                0.15
                                                            )
                                                        )
                                                        .frame(
                                                            width: 55,
                                                            height: 55
                                                        )

                                                    Image(
                                                        systemName:
                                                            "mappin.and.ellipse"
                                                    )
                                                    .font(
                                                        .system(
                                                            size: 22
                                                        )
                                                    )
                                                    .foregroundStyle(
                                                        Color(
                                                            "buttoncolor"
                                                        )
                                                    )
                                                }


                                                VStack(
                                                    alignment: .leading,
                                                    spacing: 3
                                                ) {

                                                    Text(
                                                        result.title
                                                    )
                                                    .font(
                                                        .system(
                                                            size: 19,
                                                            weight: .medium,
                                                            design: .serif
                                                        )
                                                    )
                                                    .foregroundStyle(
                                                        Color(
                                                            "FontColor"
                                                        )
                                                    )
                                                    .lineLimit(
                                                        1
                                                    )


                                                    if !result
                                                        .subtitle
                                                        .isEmpty {

                                                        Text(
                                                            result.subtitle
                                                        )
                                                        .font(
                                                            .system(
                                                                size: 13,
                                                                design: .serif
                                                            )
                                                        )
                                                        .foregroundStyle(
                                                            Color(
                                                                "FontColor"
                                                            )
                                                            .opacity(
                                                                0.65
                                                            )
                                                        )
                                                        .lineLimit(
                                                            1
                                                        )
                                                    }
                                                }


                                                Spacer()


                                                if selectedDestination ==
                                                    result.title {

                                                    Image(
                                                        systemName:
                                                            "checkmark"
                                                    )
                                                    .font(
                                                        .system(
                                                            size: 20,
                                                            weight: .medium
                                                        )
                                                    )
                                                    .foregroundStyle(
                                                        Color(
                                                            "FontColor"
                                                        )
                                                    )
                                                }
                                            }
                                            .padding(
                                                .horizontal,
                                                12
                                            )
                                            .frame(
                                                height: 68
                                            )
                                            .background(
                                                Color(
                                                    red: 0.961,
                                                    green: 0.929,
                                                    blue: 0.890
                                                )
                                            )
                                            .clipShape(
                                                RoundedRectangle(
                                                    cornerRadius: 34
                                                )
                                            )
                                            .overlay {

                                                RoundedRectangle(
                                                    cornerRadius: 34
                                                )
                                                .stroke(
                                                    Color(
                                                        red: 0.882,
                                                        green: 0.831,
                                                        blue: 0.769
                                                    ),
                                                    lineWidth: 1
                                                )
                                            }
                                            .shadow(
                                                color:
                                                    .black.opacity(
                                                        0.13
                                                    ),
                                                radius: 3,
                                                x: 0,
                                                y: 3
                                            )
                                        }
                                        .buttonStyle(
                                            .plain
                                        )
                                    }
                                }
                            }
                        }


                        // MARK: Selected Destination

                        if !selectedDestination
                            .isEmpty &&
                            !showSearchResults {

                            Text(
                                "Selected destination"
                            )
                            .font(
                                .system(
                                    size: 25,
                                    weight: .semibold,
                                    design: .serif
                                )
                            )
                            .foregroundStyle(
                                Color("FontColor")
                            )


                            HStack(
                                spacing: 15
                            ) {

                                ZStack {

                                    Circle()
                                        .fill(
                                            Color(
                                                "buttoncolor"
                                            )
                                            .opacity(
                                                0.15
                                            )
                                        )
                                        .frame(
                                            width: 58,
                                            height: 58
                                        )

                                    Image(
                                        systemName:
                                            "mappin.and.ellipse"
                                    )
                                    .font(
                                        .system(
                                            size: 23
                                        )
                                    )
                                    .foregroundStyle(
                                        Color(
                                            "buttoncolor"
                                        )
                                    )
                                }


                                Text(
                                    selectedDestination
                                )
                                .font(
                                    .system(
                                        size: 22,
                                        design: .serif
                                    )
                                )
                                .foregroundStyle(
                                    Color("FontColor")
                                )


                                Spacer()


                                Image(
                                    systemName:
                                        "checkmark"
                                )
                                .font(
                                    .system(
                                        size: 23,
                                        weight: .medium
                                    )
                                )
                                .foregroundStyle(
                                    Color(
                                        "FontColor"
                                    )
                                )
                                .padding(
                                    .trailing,
                                    8
                                )
                            }
                            .padding(
                                .horizontal,
                                10
                            )
                            .frame(
                                height: 72
                            )
                            .background(
                                Color(
                                    red: 0.961,
                                    green: 0.929,
                                    blue: 0.890
                                )
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 36
                                )
                            )
                            .overlay {

                                RoundedRectangle(
                                    cornerRadius: 36
                                )
                                .stroke(
                                    Color(
                                        red: 0.882,
                                        green: 0.831,
                                        blue: 0.769
                                    ),
                                    lineWidth: 1
                                )
                            }
                            .shadow(
                                color:
                                    .black.opacity(
                                        0.15
                                    ),
                                radius: 3,
                                x: 0,
                                y: 4
                            )
                        }


                        // MARK: Popular Destinations

                        if !showSearchResults {

                            Text(
                                "Popular destinations"
                            )
                            .font(
                                .system(
                                    size: 25,
                                    weight: .semibold,
                                    design: .serif
                                )
                            )
                            .foregroundStyle(
                                Color(
                                    "FontColor"
                                )
                            )


                            VStack(
                                spacing: 11
                            ) {

                                ForEach(
                                    destinations,
                                    id: \.0
                                ) { destination in

                                    Button {

                                        selectedDestination =
                                            destination.0

                                        searchText = ""

                                        showSearchResults =
                                            false

                                    } label: {

                                        HStack(
                                            spacing: 18
                                        ) {

                                            Image(
                                                destination.1
                                            )
                                            .resizable()
                                            .scaledToFill()
                                            .frame(
                                                width: 60,
                                                height: 60
                                            )
                                            .clipShape(
                                                Circle()
                                            )


                                            Text(
                                                destination.0
                                            )
                                            .font(
                                                .system(
                                                    size: 22,
                                                    design: .serif
                                                )
                                            )
                                            .foregroundStyle(
                                                Color(
                                                    "FontColor"
                                                )
                                            )


                                            Spacer()


                                            if selectedDestination ==
                                                destination.0 {

                                                Image(
                                                    systemName:
                                                        "checkmark"
                                                )
                                                .font(
                                                    .system(
                                                        size: 24,
                                                        weight: .medium
                                                    )
                                                )
                                                .foregroundStyle(
                                                    Color(
                                                        "FontColor"
                                                    )
                                                )
                                                .padding(
                                                    .trailing,
                                                    8
                                                )
                                            }
                                        }
                                        .padding(
                                            .horizontal,
                                            10
                                        )
                                        .frame(
                                            height: 72
                                        )
                                        .background(
                                            Color(
                                                red: 0.961,
                                                green: 0.929,
                                                blue: 0.890
                                            )
                                        )
                                        .clipShape(
                                            RoundedRectangle(
                                                cornerRadius: 36
                                            )
                                        )
                                        .overlay {

                                            RoundedRectangle(
                                                cornerRadius: 36
                                            )
                                            .stroke(
                                                Color(
                                                    red: 0.882,
                                                    green: 0.831,
                                                    blue: 0.769
                                                ),
                                                lineWidth: 1
                                            )
                                        }
                                        .shadow(
                                            color:
                                                .black.opacity(
                                                    0.15
                                                ),
                                            radius: 3,
                                            x: 0,
                                            y: 4
                                        )
                                    }
                                    .buttonStyle(
                                        .plain
                                    )
                                }
                            }
                        }


                        // MARK: Continue Button

                        Button {

                            guard !selectedDestination
                                .isEmpty
                            else {
                                return
                            }


                            let trip =
                                TripPreferences(
                                    country:
                                        selectedDestination
                                )


                            modelContext.insert(
                                trip
                            )


                            do {

                                try modelContext.save()

                                savedTrip =
                                    trip

                            } catch {

                                print(
                                    "Failed to save trip:",
                                    error
                                )
                            }

                        } label: {

                            HStack(
                                spacing: 20
                            ) {

                                Text(
                                    "Continue"
                                )


                                Image(
                                    systemName:
                                        "arrow.right"
                                )
                            }
                            .font(
                                .system(
                                    size: 20,
                                    weight: .bold,
                                    design: .serif
                                )
                            )
                            .foregroundStyle(
                                .white
                            )
                            .frame(
                                width: 220,
                                height: 56
                            )
                            .background(
                                Color(
                                    "buttoncolor"
                                )
                            )
                            .clipShape(
                                Capsule()
                            )
                            .shadow(
                                color:
                                    .black.opacity(
                                        0.28
                                    ),
                                radius: 5,
                                x: 0,
                                y: 4
                            )
                        }
                        .disabled(
                            selectedDestination
                                .isEmpty
                        )
                        .opacity(
                            selectedDestination
                                .isEmpty
                            ? 0.5
                            : 1
                        )
                        .frame(
                            maxWidth: .infinity
                        )
                        .padding(
                            .top,
                            15
                        )
                        .padding(
                            .bottom,
                            20
                        )
                    }
                    .padding(
                        .horizontal,
                        28
                    )
                    .padding(
                        .top,
                        55
                    )
                }
            }
        }


        // MARK: - Step 3 Navigation
        //
        // Pushes forward داخل الـ NavigationStack الرئيسي

        .navigationDestination(
            item: $savedTrip
        ) { trip in

            DaysOfTravel(
                trip: trip
            )
        }
    }
}


// MARK: - Preview

#Preview {

    NavigationStack {

        DestinationView()
    }
}
