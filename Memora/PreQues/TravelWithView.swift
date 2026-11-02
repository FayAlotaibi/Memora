//
//  ContentView2.swift
//  Memora
//
//  Created by Fay on 21/02/1448 AH.
//


//
//  ContentView 2.swift
//  Memora
//
//  Created by Fay on 20/02/1448 AH.
//

import SwiftUI
import SwiftData

struct TravelWithView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var selectedOption = "Solo"
    @State private var goToChallengeLevel = false
    @Bindable var trip: TripPreferences
    init(trip: TripPreferences) {
        self.trip = trip
        _selectedOption = State(
            initialValue: trip.travelWith ?? "Solo"
        )
    }
    let options = [
        ("Solo", "pic1"),
        ("Partner", "pic2"),
        ("Family", "pic3"),
        ("Friends", "pic4")
    ]
    
    var body: some View {
        
        ZStack {
            
          Color("Backgroundcolor")
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // Progress bar
                VStack(spacing: 14) {
                    
                    HStack(spacing: 0) {
                        
                        ForEach(0..<6) { index in
                            
                            Circle()
                                .fill(
                                    index < 4
                                    ? Color(
                                        red: 44 / 255,
                                        green: 62 / 255,
                                        blue: 46 / 255
                                    )
                                    : Color(
                                        red: 140 / 255,
                                        green: 170 / 255,
                                        blue: 144 / 255
                                    )
                                )
                                .frame(width: 10, height: 10)
                            
                            if index < 5 {
                                
                                Rectangle()
                                    .fill(
                                        index < 3
                                        ? Color(
                                            red: 44 / 255,
                                            green: 62 / 255,
                                            blue: 46 / 255
                                        )
                                        : Color(
                                            red: 140 / 255,
                                            green: 170 / 255,
                                            blue: 144 / 255
                                        )
                                    )
                                    .frame(height: 2)
                            }
                        }
                    }
                    .padding(.horizontal, 35)
                    
                    Text("Step 4 of 6")
                        .font(.system(size: 18, design: .serif))
                        .foregroundStyle(
                            Color("FontColor"
                                
                            )
                        )
                }
                .padding(.top, 28)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("Who are you traveling with?")
                        .font(
                            .system(
                                size: 24,
                                weight: .bold,
                                design: .serif
                            )
                        )
                        .foregroundStyle(
                            Color("FontColor"
                                
                            )
                        )
                    
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 28),
                            GridItem(.flexible())
                        ],
                        spacing: 28
                    ) {
                        
                        ForEach(options, id: \.0) { option in
                            
                            Button {
                                selectedOption = option.0
                            } label: {
                                
                                VStack(spacing: 0) {
                                    
                                    Image(option.1)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 120)
                                    
                                    Text(option.0)
                                        .font(
                                            .system(
                                                size: 24,
                                                weight: .medium,
                                                design: .serif
                                            )
                                        )
                                        .foregroundStyle(
                                            Color("FontColor"
                                                
                                            )
                                        )
                                        .padding(.bottom, 10)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 190)
                                .background(
                                    Color(red: 0.961, green: 0.929, blue: 0.890)
                                )
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 22)
                                )
                                .overlay {
                                    
                                    RoundedRectangle(cornerRadius: 22)
                                        .stroke(
                                            selectedOption == option.0
                                            ?  Color("FontColor"
                                                     
                                                    )
                                            : Color.clear,
                                            lineWidth: 2
                                        )
                                }
                                .shadow(
                                    color: .black.opacity(0.18),
                                    radius: 4,
                                    x: 0,
                                    y: 4
                                )
                            }
                        }
                    }
                    .padding(.top, 72)
                    
                    
                    Button {
                        
                        trip.travelWith = selectedOption
                        
                        print("Country: \(trip.country)")
                        print("Departure: \(trip.startDate)")
                        print("Return: \(trip.endDate)")
                        print("Traveling with: \(trip.travelWith ?? "None")")
                        
                        do {
                            try modelContext.save()
                            print("Travel with saved successfully")
                            
                            goToChallengeLevel = true
                            
                        } catch {
                            print("Failed to save travel with: \(error)")
                        }
                        
                    } label: {
                        HStack(spacing: 20) {
                            Text("Continue")
                            
                            Image(systemName: "arrow.right")
                        }
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .foregroundStyle(.white)
                        .frame(width: 220, height: 56)
                        .background(Color("buttoncolor"))
                        .clipShape(Capsule())
                        .shadow(
                            color: .black.opacity(0.28),
                            radius: 5,
                            x: 0,
                            y: 4
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 65)
                    .navigationDestination(isPresented: $goToChallengeLevel) {
                        ChallengeLevelView(trip: trip)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 75)
                
                Spacer(minLength: 15)
            }
        }
    }
}

#Preview {
    NavigationStack{
        TravelWithView(
                    trip: TripPreferences(country: "Italy")
                )
    }
    
}
