import SwiftUI
import SwiftData
struct PhotoPreferenceView: View {
    @Environment(\.modelContext) private var modelContext
       
       @Bindable var trip: TripPreferences
    @State private var goToFinalQuest = false

    @State private var selectedCategories: Set<String> = [
        "Landscapes",
        "Food",
        "Funny Moments"
    ]

    @State private var selectedAvoidItems: Set<String> = []

    let avoidItems = [
        "Talking to strangers",
        "Long Walks",
        "Crowded places",
        "Paid activities",
        "Food challenges"
    ]

    let categories = [
        ("Landscapes", "mountain.2"),
        ("People", "person.2"),
        ("Architecture", "building.2"),
        ("Food", "fork.knife"),
        ("Animals", "dog"),
        ("Funny Moments", "face.smiling"),
        ("Street Art", "paintbrush.pointed"),
        ("Nature", "tree")
    ]

    

   

    

    let cardColor = Color(
        red: 245/255,
        green: 237/255,
        blue: 227/255
    )

    var body: some View {

        ZStack {

          Color("Backgroundcolor")
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: Progress Bar
                VStack(spacing: 13) {

                    HStack(spacing: 0) {

                        ForEach(0..<6) { index in

                            Circle()
                                .fill(Color("FontColor"))
                                .frame(width: 10, height: 10)

                            if index < 5 {
                                Rectangle()
                                    .fill(Color("FontColor"))
                                    .frame(height: 2)
                            }
                        }
                    }
                    .padding(.horizontal, 35)

                    Text("Step 6 of 6")
                        .font(
                            .system(
                                size: 18,
                                design: .serif
                            )
                        )
                        .foregroundStyle(Color("FontColor"))
                }
                .padding(.top, 24)
                .padding(.bottom, 12)

                ScrollView(showsIndicators: false) {

                    VStack(
                        alignment: .leading,
                        spacing: 0
                    ) {

                        Text("What do you\nenjoy photographing?")
                            .font(
                                .system(
                                    size: 30,
                                    weight: .bold,
                                    design: .serif
                                )
                            )
                            .foregroundStyle(Color("FontColor"))
                            .lineSpacing(-2)

                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible())
                            ],
                            spacing: 16
                        ) {

                            ForEach(categories, id: \.0) { category in

                                Button {
                                    selectCategory(category.0)
                                } label: {

                                    VStack(spacing: 8) {

                                        Image(systemName: category.1)
                                            .font(.system(size: 27))
                                            .foregroundStyle(Color("buttoncolor"))
                                            .frame(height: 30)

                                        Text(category.0)
                                            .font(
                                                .system(
                                                    size: 16,
                                                    weight: .medium,
                                                    design: .serif
                                                )
                                            )
                                            .foregroundStyle(Color("FontColor"))
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 110)
                                    .background(cardColor)
                                    .clipShape(
                                        RoundedRectangle(
                                            cornerRadius: 12
                                        )
                                    )
                                    .overlay {

                                        RoundedRectangle(
                                            cornerRadius: 12
                                        )
                                        .stroke(
                                            selectedCategories.contains(category.0)
                                            ? Color("FontColor")
                                            : Color.clear,
                                            lineWidth: 2
                                        )
                                    }
                                    .shadow(
                                        color: .black.opacity(0.16),
                                        radius: 3,
                                        x: 0,
                                        y: 4
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.top, 48)

                        // MARK: Avoid Section
                        VStack(
                            alignment: .leading,
                            spacing: 13
                        ) {

                            Text("Anything you’d like to avoid?")
                                .font(
                                    .system(
                                        size: 21,
                                        weight: .bold,
                                        design: .serif
                                    )
                                )
                                .foregroundStyle(Color("FontColor"))

                            FlowLayout(spacing: 8) {

                                ForEach(
                                    avoidItems,
                                    id: \.self
                                ) { item in

                                    Button {
                                        toggleAvoidItem(item)
                                    } label: {

                                        Text(item)
                                            .font(
                                                .system(
                                                    size: 13,
                                                    design: .serif
                                                )
                                            )
                                            .foregroundStyle(Color("FontColor"))
                                            .padding(.horizontal, 12)
                                            .frame(height: 32)
                                            .background(
                                                selectedAvoidItems.contains(item)
                                                ? Color("buttoncolor").opacity(0.30)
                                                : Color.white.opacity(0.45)
                                            )
                                            .clipShape(Capsule())
                                            .overlay {

                                                Capsule()
                                                    .stroke(
                                                        selectedAvoidItems.contains(item)
                                                        ? Color("FontColor")
                                                        : Color.clear,
                                                        lineWidth: 1.5
                                                    )
                                            }
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(.horizontal, 23)
                        .padding(.vertical, 20)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .background(cardColor)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 30
                            )
                        )
                        .shadow(
                            color: .black.opacity(0.16),
                            radius: 4,
                            x: 0,
                            y: 4
                        )
                        .padding(.top, 35)
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 25)
                }

                // MARK: Continue Button
                Button {
                    
                    // Save photography interests
                    trip.photographyInterests = Array(selectedCategories)
                    
                    // Save things to avoid
                    trip.avoid = Array(selectedAvoidItems)
                    
                    print("---------- TRIP PREFERENCES ----------")
                    print("Country: \(trip.country)")
                    print("Departure: \(trip.startDate)")
                    print("Return: \(trip.endDate)")
                    print("Traveling with: \(trip.travelWith ?? "None")")
                    print("Difficulty: \(trip.difficulty ?? "None")")
                    print("Photography interests: \(trip.photographyInterests)")
                    print("Avoid: \(trip.avoid)")
                    print("---------------------------------------")
                    
                    do {
                        try modelContext.save()
                        print("Trip preferences saved successfully")
                        
                        goToFinalQuest = true
                        
                    } catch {
                        print("Failed to save trip preferences: \(error)")
                    }
                    
                } label: {
                    
                    HStack(spacing: 20) {
                        
                        Text("Continue")
                        
                        Image(systemName: "arrow.right")
                    }
                    .font(
                        .system(
                            size: 20,
                            weight: .bold,
                            design: .serif
                        )
                    )
                    .foregroundStyle(.white)
                    .frame(
                        width: 220,
                        height: 56
                    )
                    .background(
                        Color(
                            red: 0.831,
                            green: 0.627,
                            blue: 0.090
                        )
                    )
                    .clipShape(Capsule())
                    .shadow(
                        color: .black.opacity(0.28),
                        radius: 5,
                        x: 0,
                        y: 4
                    )
                }
                .padding(.top, 10)
                .padding(.bottom, 18)
                .navigationDestination(isPresented: $goToFinalQuest) {
                    FinalQuestView(trip: trip)
                }
            }
        }
    }

    // MARK: Category Selection
    func selectCategory(_ category: String) {

        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }

    // MARK: Avoid Selection
    func toggleAvoidItem(_ item: String) {

        if selectedAvoidItems.contains(item) {
            selectedAvoidItems.remove(item)
        } else {
            selectedAvoidItems.insert(item)
        }
    }
}


// MARK: Flow Layout
struct FlowLayout: Layout {

    var spacing: CGFloat = 8

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {

        let maxWidth = proposal.width ?? 0

        var width: CGFloat = 0
        var height: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {

            let size = subview.sizeThatFits(.unspecified)

            if width + size.width > maxWidth {

                width = 0
                height += rowHeight + spacing
                rowHeight = 0
            }

            width += size.width + spacing
            rowHeight = max(
                rowHeight,
                size.height
            )
        }

        return CGSize(
            width: maxWidth,
            height: height + rowHeight
        )
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {

        var x = bounds.minX
        var y = bounds.minY
        var rowHeight: CGFloat = 0

        for subview in subviews {

            let size = subview.sizeThatFits(.unspecified)

            if x + size.width > bounds.maxX {

                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }

            subview.place(
                at: CGPoint(
                    x: x,
                    y: y
                ),
                proposal: ProposedViewSize(size)
            )

            x += size.width + spacing

            rowHeight = max(
                rowHeight,
                size.height
            )
        }
    }
}


#Preview {
    NavigationStack {
        PhotoPreferenceView(
                  trip: TripPreferences(country: "Italy")
              )
    }
}
