//
//  ContentView.swift
//  Hangout Finder App
//
//  Created by McKenzie, Cameron - Student on 11/30/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedCity = "Denver, CO"
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    let cities = [
        "Denver, CO",
        "Los Angeles, CA",
        "Miami, FL",
        "New York, NY",
        "Phoenix, AZ",
        "Seattle, WA"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color("BGColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 28) {
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 130)
                        .padding(.top, 40)
                    
                    VStack(spacing: 10) {
                        Text("Choose Your City")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Picker("Select City", selection: $selectedCity) {
                            ForEach(cities, id: \.self) { city in
                                Text(city)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(Color("ButtonColor"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.25))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    
                    NavigationLink(
                        destination: HomeView(selectedCity: selectedCity)
                            .environmentObject(favoritesManager)
                    ) {
                        Text("Find a Hangout")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("ButtonColor"))
                            .foregroundColor(.white)
                            .cornerRadius(22)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    Image("bottomImage")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 10)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FavoritesManager())
}
