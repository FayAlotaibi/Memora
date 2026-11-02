//
//  ContentView 2.swift
//  Memora
//
//  Created by Fay on 20/02/1448 AH.
//
import SwiftUI
import SwiftData

struct DaysOfTravel: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var departureDate = Date()
    @Bindable var trip: TripPreferences
    
    @State private var returnDate =
        Calendar.current.date(
            byAdding: .day,
            value: 1,
            to: Date()
        ) ?? Date()
    @State private var goToTravelWith = false
    
    var numberOfDays: Int {
        
        let calendar = Calendar.current
        
        let start = calendar.startOfDay(for: departureDate)
        let end = calendar.startOfDay(for: returnDate)
        
        let difference = calendar.dateComponents(
            [.day],
            from: start,
            to: end
        ).day ?? 0
        
        return difference + 1
    }
    
    var body: some View {
        
        ZStack {
            
            Color("Backgroundcolor")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // Progress bar
                VStack(spacing: 16) {
                    
                    HStack(spacing: 0) {
                        
                        ForEach(0..<6) { index in
                            
                            Circle()
                                .fill(
                                    index < 3
                                    ? Color(
                                        red: 0.173,
                                        green: 0.243,
                                        blue: 0.180
                                    )
                                    : Color(
                                        red: 0.549,
                                        green: 0.667,
                                        blue: 0.565
                                    )
                                )
                                .frame(width: 10, height: 10)
                            
                            if index < 5 {
                                
                                Rectangle()
                                    .fill(
                                        index < 2
                                        ? Color(
                                            red: 0.173,
                                            green: 0.243,
                                            blue: 0.180
                                        )
                                        : Color(
                                            red: 0.549,
                                            green: 0.667,
                                            blue: 0.565
                                        )
                                    )
                                    .frame(height: 2)
                            }
                        }
                    }
                    .padding(.horizontal, 36)
                    
                    Text("Step 3 of 6")
                        .font(
                            .system(
                                size: 18,
                                weight: .medium,
                                design: .serif
                            )
                        )
                        .foregroundStyle(
                            (
                                Color("FontColor")
                            )
                        )
                }
                .padding(.top, 28)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("When are you traveling?")
                        .font(
                            .system(
                                size: 28,
                                weight: .bold,
                                design: .serif
                            )
                        )
                        .foregroundStyle(
                            (Color("FontColor")
                            )
                        )
                        .lineLimit(2)
                    
                    // Departure Date
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Departure Date")
                            .font(
                                .system(
                                    size: 18,
                                    weight: .medium,
                                    design: .serif
                                )
                            )
                            .foregroundStyle(
                               (Color("FontColor")
                                )
                            )
                        
                        DatePicker(
                            "Select Date",
                            selection: $departureDate,
                            in: Date()...,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.compact)
                        .tint(
                           (Color("FontColor")
                            )
                        )
                        .padding(.horizontal, 20)
                        .frame(height: 66)
                        .background(
                            Color(
                                red: 0.961,
                                green: 0.929,
                                blue: 0.890
                            )
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        )
                        .overlay {
                            
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(
                                 red: 0.882,
                                    green: 0.831,
                                    blue: 0.769
                                    ),
                                    lineWidth: 1
                                )
                        }
                        .shadow(
                            color: .black.opacity(0.18),
                            radius: 4,
                            x: 0,
                            y: 4
                        )
                    }
                    .padding(.top, 60)
                    
                    // Return Date
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Return Date")
                            .font(
                                .system(
                                    size: 18,
                                    weight: .medium,
                                    design: .serif
                                )
                            )
                            .foregroundStyle(
                                Color("FontColor")
                                )
                          
                        
                        DatePicker(
                            "Select Date",
                            selection: $returnDate,
                            in: departureDate...,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.compact)
                        .tint(
                            Color("FontColor")
                            )
                        
                        .padding(.horizontal, 20)
                        .frame(height: 66)
                        .background(
                            Color(
                                red: 0.961,
                                green: 0.929,
                                blue: 0.890
                            )
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        )
                        .overlay {
                            
                            RoundedRectangle(cornerRadius: 8)
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
                            color: .black.opacity(0.18),
                            radius: 4,
                            x: 0,
                            y: 4
                        )
                    }
                    .padding(.top, 28)
                    
                    Text("Trip duration: \(numberOfDays) days")
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
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    
                    Button {
                        
                        // Save dates to the SAME TripPreferences object
                        trip.startDate = departureDate
                        trip.endDate = returnDate
                        
                        print("Country: \(trip.country)")
                        print("Departure: \(departureDate)")
                        print("Return: \(returnDate)")
                        print("Duration: \(numberOfDays) days")
                        
                        do {
                            try modelContext.save()
                            print("Dates saved successfully")
                            
                            goToTravelWith = true
                            
                        } catch {
                            print("Failed to save dates: \(error)")
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
                    .padding(.bottom, 28)
                    .navigationDestination(isPresented: $goToTravelWith) {
                        TravelWithView(trip: trip)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 90)
            }
        }
        .onChange(of: departureDate) {
            
            if returnDate < departureDate {
                
                returnDate =
                    Calendar.current.date(
                        byAdding: .day,
                        value: 1,
                        to: departureDate
                    ) ?? departureDate
            }
        }
    }
}

#Preview {
    NavigationStack{
        DaysOfTravel( trip: TripPreferences(country: "Italy"))
    }
}
