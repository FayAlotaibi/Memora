//
//  SwiftUIView.swift
//  QVoyage 2
//
//  Created by Najla Abuhaimed on 03/08/2026.
//

import SwiftUI

struct SwiftUIView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    // إذا كانت الصفحة مفتوحة من Start New Trip
    // يظهر زر الرجوع
    var showBackButton: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            Color("Backgroundcolor")
                
            .ignoresSafeArea()
            
            
            // MARK: - Back Button
            
            if showBackButton {
                
                Button {
                    dismiss()
                    
                } label: {
                    
                    Image(systemName: "chevron.left")
                        .font(
                            .system(
                                size: 24,
                                weight: .bold
                            )
                        )
                        .foregroundColor(.white)
                        .frame(
                            width: 58,
                            height: 58
                        )
                        .background(Color("buttoncolor"))
                        .clipShape(Circle())
                        .shadow(
                            radius: 4,
                            y: 2
                        )
                }
                .padding(.leading, 25)
                .padding(.top, 25)
                .zIndex(10)
            }
            
            
            // MARK: - Main Content
            
            VStack {
                
                Text(
                    "Are you ready to\nadd some fun to\nyour trip?"
                )
                .font(
                    .system(size: 39, design: .serif
                    )
                )
                .fontWeight(.regular)
                .foregroundColor(
                    Color("FontColor"
                    )
                )
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
                .frame(
                    maxWidth: 350
                )
                
                
                // MARK: - Illustration
                
                ZStack {
                    
                    Image("picmain")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 280
                        )
                    
                    
                    Image("cloud")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 48
                        )
                        .offset(
                            x: -135,
                            y: -80
                        )
                    
                    
                    Image("Vector")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 135
                        )
                        .offset(
                            x: 105,
                            y: -135
                        )
                    
                    
                    Image("mapping")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 28
                        )
                        .offset(
                            x: 170,
                            y: -180
                        )
                        .zIndex(3)
                    
                    
                    Image("cloud2")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 40
                        )
                        .offset(
                            x: 155,
                            y: 5
                        )
                }
                .frame(
                    width: 350,
                    height: 380
                )
                
                
                // MARK: - Start Button
                
                NavigationLink {
                    
                    WelcomeView()
                    
                } label: {
                    
                    HStack {
                        
                        Text("Start")
                        
                        Image(
                            systemName:
                                "arrow.right"
                        )
                    }
                    .font(
                        .system(
                            size: 28,
                            weight: .medium,
                            design: .serif
                        )
                    )
                    .foregroundColor(.white)
                    .frame(
                        width: 200,
                        height: 60
                    )
                    .background(Color("buttoncolor"))
                    .clipShape(
                        Capsule()
                    )
                    .shadow(
                        radius: 4,
                        y: 4
                    )
                    .offset(
                        y: 20
                    )
                }
                .offset(
                    y: -40
                )
                
                
                Spacer()
                
                Spacer()
            }
            .padding(
                .horizontal,
                25
            )
            .padding(
                .bottom,
                15
            )
            .padding(
                .top,
                80
            )
            .frame(
                maxWidth: .infinity
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}


// MARK: - Preview

#Preview {
    
    NavigationStack {
        
        SwiftUIView(
            showBackButton: false
        )
    }
}
