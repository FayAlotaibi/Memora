//
//  ChallengeLevelView.swift
//  Memora
//
//  Created by Fay on 21/02/1448 AH.
//

import SwiftUI
import SwiftData

struct ChallengeLevelView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: TripPreferences
    @State private var selectedLevel = "Medium"
    @State private var goToPhotoPreference = false
    
    let levels = [
        (
            title: "Easy",
            description: "Fun and simple challenges to enjoy your trip.",
            icon: "leaf"
        ),
        (
            title: "Medium",
            description: "Balanced challenges to explore more.",
            icon: "mountain.2"
        ),
        (
            title: "Explorer",
            description: "Adventurous challenges for the brave at heart!",
            icon: "flag.fill"
        )
    ]
    
    var body: some View {
        
        ZStack {
            
            Color("Backgroundcolor")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                VStack(spacing: 12) {
                    
                    HStack(spacing: 0) {
                        
                        ForEach(0..<6) { index in
                            
                            Circle()
                                .fill(
                                    index < 5
                                    ? Color(red: 44/255, green: 62/255, blue: 46/255)
                                    : Color(red: 140/255, green: 170/255, blue: 144/255)
                                )
                                .frame(width: 10, height: 10)
                            
                            if index < 5 {
                                Rectangle()
                                    .fill(
                                        index < 4
                                        ? Color(red: 44/255, green: 62/255, blue: 46/255)
                                        : Color(red: 140/255, green: 170/255, blue: 144/255)
                                    )
                                    .frame(height: 2)
                            }
                        }
                    }
                    .padding(.horizontal, 35)
                    
                    Text("Step 5 of 6")
                        .font(.system(size: 18, design: .serif))
                        .foregroundStyle(
                            Color("FontColor")
                        )
                }
                .padding(.top, 25)
                .padding(.bottom, 12)
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text("How challenging do you want it?")
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
                        
                        VStack(spacing: 14) {
                            
                            ForEach(levels, id: \.title) { level in
                                
                                Button {
                                    selectedLevel = level.title
                                } label: {
                                    
                                    HStack(spacing: 16) {
                                        
                                        Image(systemName: level.icon)
                                            .font(.system(size: 28))
                                            .foregroundStyle(
                                                Color("buttoncolor")
                                            )
                                            .frame(width: 42)
                                        
                                        VStack(alignment: .leading, spacing: 3) {
                                            
                                            Text(level.title)
                                                .font(
                                                    .system(
                                                        size: 27,
                                                        weight: .medium,
                                                        design: .serif
                                                    )
                                                )
                                            
                                            Text(level.description)
                                                .font(
                                                    .system(
                                                        size: 13,
                                                        design: .serif
                                                    )
                                                )
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(2)
                                        }
                                        .foregroundStyle(
                                            Color("FontColor")
                                        )
                                        
                                        Spacer()
                                        
                                        Circle()
                                            .fill(
                                                selectedLevel == level.title
                                                ? Color("buttoncolor")
                                                : Color.clear
                                            )
                                            .frame(width: 38, height: 38)
                                            .overlay {
                                                Circle()
                                                    .stroke(
                                                        Color(red: 44/255, green: 62/255, blue: 46/255),
                                                        lineWidth: 1.5
                                                    )
                                            }
                                    }
                                    .padding(.horizontal, 22)
                                    .frame(height: 105)
                                    .background(
                                        Color(red: 245/255,
                                              green: 237/255,
                                              blue: 227/255)
                                    )
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 52)
                                    )
                                    .shadow(
                                        color: .black.opacity(0.16),
                                        radius: 4,
                                        x: 0,
                                        y: 4
                                    )
                                }
                            }
                        }
                        .padding(.top, 45)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("Example for \(selectedLevel)")
                                .font(
                                    .system(
                                        size: 21,
                                        weight: .semibold,
                                        design: .serif
                                    )
                                )
                            
                            HStack(spacing: 8) {
                                Image(systemName: "camera")
                                Text(exampleText1)
                            }
                            
                            HStack(spacing: 8) {
                                Image(systemName: "takeoutbag.and.cup.and.straw")
                                Text(exampleText2)
                            }
                            
                            HStack(spacing: 8) {
                                Image(systemName: "person.2")
                                Text(exampleText3)
                            }
                        }
                        .font(.system(size: 15, design: .serif))
                        .foregroundStyle(
                            Color("FontColor")
                        )
                        .padding(.horizontal, 25)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 150)
                        .background(
                            Color(red: 0.961, green: 0.929, blue: 0.890)
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 28)
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
                
                
                Button {
                    
                    // Save the selected difficulty
                    trip.difficulty = selectedLevel
                    
                    print("Country: \(trip.country)")
                    print("Departure: \(trip.startDate)")
                    print("Return: \(trip.endDate)")
                    print("Traveling with: \(trip.travelWith ?? "None")")
                    print("Difficulty: \(trip.difficulty ?? "None")")
                    
                    do {
                        try modelContext.save()
                        print("Difficulty saved successfully")
                        
                        goToPhotoPreference = true
                        
                    } catch {
                        print("Failed to save difficulty: \(error)")
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
                        Color("buttoncolor")
                    )
                    .clipShape(Capsule())
                    .shadow(
                        color: .black.opacity(0.28),
                        radius: 5,
                        x: 0,
                        y: 4
                    )
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
                .padding(.bottom, 15)
                .navigationDestination(isPresented: $goToPhotoPreference) {
                    PhotoPreferenceView(trip: trip)
                }
            }
        }
    }
    
    var exampleText1: String {
        if selectedLevel == "Easy" {
            return "Photograph something colorful"
        } else if selectedLevel == "Explorer" {
            return "Photograph a place few people visit"
        } else {
            return "Photograph a hidden alley"
        }
    }
    
    var exampleText2: String {
        if selectedLevel == "Easy" {
            return "Try a popular local snack"
        } else if selectedLevel == "Explorer" {
            return "Try an unfamiliar local dish"
        } else {
            return "Try a local dessert"
        }
    }
    
    var exampleText3: String {
        if selectedLevel == "Easy" {
            return "Capture a relaxing travel moment"
        } else if selectedLevel == "Explorer" {
            return "Talk to a local and ask for a hidden spot"
        } else {
            return "Capture a café where locals gather"
        }
    }
}

#Preview {
    NavigationStack{
        ChallengeLevelView(
                   trip: TripPreferences(country: "Italy")
               )
    }
}
