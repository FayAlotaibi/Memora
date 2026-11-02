//
//  WelcomeView.swift
//  Memora
//
//  Created by Fay on 21/02/1448 AH.
//

import SwiftUI

struct WelcomeView: View {
    
  
    
    var body: some View {
        ZStack {
            
           Color("Backgroundcolor")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                
                ZStack {
                    Capsule()
                        .fill(Color("FontColor"))
                        .frame(height: 2)
                    
                    HStack {
                        Circle()
                            .fill(Color("FontColor"))
                            .frame(width: 12, height: 12)
                        
                        Spacer()
                        
                        Circle()
                            .fill(Color(red: 0.55, green: 0.67, blue: 0.57))
                            .frame(width: 12, height: 12)
                        
                        Spacer()
                        
                        Circle()
                            .fill(Color(red: 0.55, green: 0.67, blue: 0.57))
                            .frame(width: 12, height: 12)
                        
                        Spacer()
                        
                        Circle()
                            .fill(Color(red: 0.55, green: 0.67, blue: 0.57))
                            .frame(width: 12, height: 12)
                        
                        Spacer()
                        
                        Circle()
                            .fill(Color(red: 0.55, green: 0.67, blue: 0.57))
                            .frame(width: 12, height: 12)
                        
                        Spacer()
                        
                        Circle()
                            .fill(Color(red: 0.55, green: 0.67, blue: 0.57))
                            .frame(width: 12, height: 12)
                    }
                }
                .padding(.horizontal, 35)
                
                Text("Step 1 of 6")
                    .font(.custom("Georgia", size: 18))
                    .foregroundColor(Color("FontColor"))
                    .padding(.top, 10)
                
                
                HStack(spacing: 8) {
                    Text("Let’s start your journey")
                        .font(.system(size: 31,weight:.medium ,design: .serif))
                        .foregroundColor(Color("FontColor"))
                    
                    Image("sparkles")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }
                .frame(maxWidth: .infinity)
                .offset(x: 10)
                .padding(.top, 50)
                
                
                Text("""
                Answer a few quick questions so we can
                create quests just for your trip
                """)
                .font(.system( size: 18,design: .serif))
                .foregroundColor(Color("FontColor"))
                .multilineTextAlignment(.center)
                .padding(.top, 30)
                
                
                ZStack {
                    Image("Vector")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110)
                        .offset(x: 95, y: -110)
                    
                    Image("man")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 190)
                    
                    Image("cloud")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .offset(x: -120, y: -50)
                    
                    Image("cloud2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .offset(x: 140, y: 5)
                    
                    Image("mapping")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 29)
                        .offset(x: 150, y: -150)
                }
                .frame(width: 350, height: 330)
                .padding(.top, 3)
                
                Spacer()
                
                
                NavigationLink {
                    DestinationView()
                    
                } label: {
                    HStack {
                        Text("Continue")

                        Image(systemName: "arrow.right")
                    }
                    .font(.system(size: 25, weight: .medium, design: .serif))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 60)
                    .background(Color("buttoncolor"))
                    .clipShape(Capsule())
                    .shadow(radius: 4, y: 4).offset(y:-28)
                }
                .offset(y: -40)
                    
                 Spacer()
                        .frame(height: 45)
                }
                .padding(.top, 25)
            }
            
            .toolbar(.hidden, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
        }
    }
    
#Preview {
    NavigationStack{
        WelcomeView()
    }
}
