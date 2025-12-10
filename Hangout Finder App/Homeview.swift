//
//  Homeview.swift
//  Hangout Finder App
//
//  Created by McKenzie, Cameron - Student on 12/1/25.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    
    var selectedCity: String
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    @State private var showCategories = false
    @State private var selectedCategory: String? = nil
    @State private var randomSpotOfDay: String = ""
    @State private var randomCategoryOfDay: String = ""
    @State private var showRandomSpot = true
    
    let categories = ["Cafe", "Arcade", "Chill", "Outdoors"]
    
    // Coordinates for all spots
    let spotCoordinates: [String: CLLocationCoordinate2D] = [
        // Denver
        "Mountain Brew Café": CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903),
        "Golden Hour Cafe": CLLocationCoordinate2D(latitude: 39.7420, longitude: -104.9870),
        "Rainy Day Café": CLLocationCoordinate2D(latitude: 39.7380, longitude: -104.9910),
        "Sunset Café": CLLocationCoordinate2D(latitude: 39.7405, longitude: -104.9850),
        "Red Rocks Park": CLLocationCoordinate2D(latitude: 39.6654, longitude: -105.2057),
        "City Park Picnic": CLLocationCoordinate2D(latitude: 39.7475, longitude: -104.9420),
        "Cherry Creek Trail": CLLocationCoordinate2D(latitude: 39.7205, longitude: -104.9400),
        "Union Station Patio": CLLocationCoordinate2D(latitude: 39.7526, longitude: -104.9968),
        
        // Los Angeles
        "Sunset Espresso": CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
        "Ocean Breeze Café": CLLocationCoordinate2D(latitude: 34.0094, longitude: -118.4973),
        "Downtown Grind": CLLocationCoordinate2D(latitude: 34.0407, longitude: -118.2468),
        "Hollywood Coffeehouse": CLLocationCoordinate2D(latitude: 34.1015, longitude: -118.3269),
        "Venice Boardwalk": CLLocationCoordinate2D(latitude: 33.9850, longitude: -118.4695),
        "Santa Monica Pier": CLLocationCoordinate2D(latitude: 34.0094, longitude: -118.4973),
        "Griffith Park": CLLocationCoordinate2D(latitude: 34.1367, longitude: -118.2942),
        "Runyon Canyon": CLLocationCoordinate2D(latitude: 34.1053, longitude: -118.3480),
        
        // Miami
        "Oceanview Café": CLLocationCoordinate2D(latitude: 25.7617, longitude: -80.1918),
        "Sunshine Brew": CLLocationCoordinate2D(latitude: 25.7743, longitude: -80.1937),
        "Downtown Café": CLLocationCoordinate2D(latitude: 25.7735, longitude: -80.1937),
        "Beachside Coffee": CLLocationCoordinate2D(latitude: 25.7907, longitude: -80.1300),
        "South Beach Boardwalk": CLLocationCoordinate2D(latitude: 25.7907, longitude: -80.1300),
        "Bayfront Park": CLLocationCoordinate2D(latitude: 25.7772, longitude: -80.1891),
        "Wynwood Walls Park": CLLocationCoordinate2D(latitude: 25.8014, longitude: -80.1991),
        "Coconut Grove Garden": CLLocationCoordinate2D(latitude: 25.7289, longitude: -80.2384),
        
        // New York
        "Central Perk Café": CLLocationCoordinate2D(latitude: 40.7851, longitude: -73.9683),
        "Brooklyn Brew": CLLocationCoordinate2D(latitude: 40.6782, longitude: -73.9442),
        "Highline Café": CLLocationCoordinate2D(latitude: 40.7480, longitude: -74.0048),
        "Downtown Espresso NY": CLLocationCoordinate2D(latitude: 40.7060, longitude: -74.0086),
        "Central Park Picnic": CLLocationCoordinate2D(latitude: 40.7851, longitude: -73.9683),
        "Highline Park": CLLocationCoordinate2D(latitude: 40.7480, longitude: -74.0048),
        "Brooklyn Bridge Park": CLLocationCoordinate2D(latitude: 40.7003, longitude: -73.9967),
        "Battery Park": CLLocationCoordinate2D(latitude: 40.7033, longitude: -74.0170),
        
        // Phoenix
        "Desert Brew": CLLocationCoordinate2D(latitude: 33.4484, longitude: -112.0740),
        "Sunrise Café": CLLocationCoordinate2D(latitude: 33.4525, longitude: -112.0750),
        "Downtown Espresso": CLLocationCoordinate2D(latitude: 33.4481, longitude: -112.0737),
        "Cactus Coffeehouse": CLLocationCoordinate2D(latitude: 33.4500, longitude: -112.0760),
        "Camelback Mountain Trail": CLLocationCoordinate2D(latitude: 33.5092, longitude: -111.9505),
        "Papago Park": CLLocationCoordinate2D(latitude: 33.4625, longitude: -111.9470),
        "Desert Botanical Garden": CLLocationCoordinate2D(latitude: 33.4628, longitude: -111.9440),
        "Encanto Park": CLLocationCoordinate2D(latitude: 33.5166, longitude: -112.0773),
        
        // Seattle
        "Pike Place Café": CLLocationCoordinate2D(latitude: 47.6097, longitude: -122.3425),
        "Rainy Day Brew": CLLocationCoordinate2D(latitude: 47.6100, longitude: -122.3425),
        "Space Needle Espresso": CLLocationCoordinate2D(latitude: 47.6205, longitude: -122.3493),
        "Downtown Coffeehouse": CLLocationCoordinate2D(latitude: 47.6080, longitude: -122.3370),
        "Gas Works Park": CLLocationCoordinate2D(latitude: 47.6456, longitude: -122.3344),
        "Kerry Park": CLLocationCoordinate2D(latitude: 47.6295, longitude: -122.3633),
        "Discovery Park": CLLocationCoordinate2D(latitude: 47.6573, longitude: -122.4050),
        "Green Lake Park": CLLocationCoordinate2D(latitude: 47.6797, longitude: -122.3470)
    ]
    
    let spotsByCityAndCategory: [String: [String: [String]]] = [:
        // your existing spotsByCityAndCategory dictionary goes here (no changes needed)
    ]
    
    func generateRandomSpot() {
        guard let cityData = spotsByCityAndCategory[selectedCity] else { return }
        let allPairs = cityData.flatMap { category, spots in
            spots.map { (category, $0) }
        }
        if let random = allPairs.randomElement() {
            randomCategoryOfDay = random.0
            randomSpotOfDay = random.1
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BGColor").ignoresSafeArea()
                
                VStack(spacing: 16) {
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 90)
                        .padding(.top, 32)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showCategories.toggle()
                            if !showCategories {
                                selectedCategory = nil
                                showRandomSpot = true
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search hangouts...")
                            Spacer()
                        }
                        .padding()
                        .background(Color.white.opacity(0.25))
                        .cornerRadius(14)
                    }
                    .padding(.horizontal)
                    
                    if showRandomSpot && !randomSpotOfDay.isEmpty {
                        NavigationLink(destination: DetailView(
                            spotName: randomSpotOfDay,
                            city: selectedCity,
                            category: randomCategoryOfDay,
                            coordinate: spotCoordinates[randomSpotOfDay] ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
                        ).environmentObject(favoritesManager)) {
                            Image("randomHangout")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .clipped()
                                .cornerRadius(20)
                                .shadow(radius: 10)
                                .padding(.top, 16)
                                .padding(.horizontal)
                        }
                        .transition(.opacity.combined(with: .scale))
                    }
                    
                    if showCategories {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(categories, id: \.self) { category in
                                    Button {
                                        withAnimation(.spring()) {
                                            selectedCategory = category
                                            showRandomSpot = false
                                        }
                                    } label: {
                                        VStack(spacing: 6) {
                                            Image(category.lowercased())
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 85, height: 85)
                                                .clipped()
                                                .cornerRadius(14)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 14)
                                                        .stroke(
                                                            selectedCategory == category ?
                                                            Color("ButtonColor") : .clear,
                                                            lineWidth: 3
                                                        )
                                                )
                                                .shadow(
                                                    color: selectedCategory == category ?
                                                    Color("ButtonColor").opacity(0.7) : .clear,
                                                    radius: 10
                                                )
                                            
                                            Text(category)
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .transition(.move(edge: .top).combined(with: .opacity))
                        }
                    }
                    
                    if let selectedCategory = selectedCategory {
                        Text("\(selectedCategory) Spots in \(selectedCity)")
                            .font(.headline)
                            .padding(.top, 8)
                    }
                    
                    ScrollView {
                        if let selectedCategory = selectedCategory,
                           let spots = spotsByCityAndCategory[selectedCity]?[selectedCategory] {
                            ForEach(spots, id: \.self) { spot in
                                SpotCardView(
                                    spot: spot,
                                    city: selectedCity,
                                    category: selectedCategory,
                                    coordinate: spotCoordinates[spot] ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
                                ).environmentObject(favoritesManager)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                        } label: {
                            VStack {
                                Image(systemName: "house.fill")
                                Text("Home").font(.caption)
                            }
                            .foregroundColor(Color("ButtonColor"))
                        }
                        .frame(maxWidth: .infinity)
                        
                        NavigationLink(destination: FavoritesView().environmentObject(favoritesManager)) {
                            VStack {
                                Image(systemName: "heart.fill")
                                Text("Favorites").font(.caption)
                            }
                            .foregroundColor(Color("ButtonColor"))
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
                .onAppear {
                    generateRandomSpot()
                }
            }
        }
    }
}

struct SpotCardView: View {
    var spot: String
    var city: String
    var category: String
    var coordinate: CLLocationCoordinate2D
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var body: some View {
        NavigationLink(destination: DetailView(
            spotName: spot,
            city: city,
            category: category,
            coordinate: coordinate
        ).environmentObject(favoritesManager)) {
            VStack(alignment: .leading, spacing: 6) {
                Text(spot)
                    .font(.headline)
                
                Text(city)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(category)
                    .font(.caption)
                    .foregroundColor(Color("ButtonColor"))
                
                Text("Tap to view details")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white.opacity(0.25))
            .cornerRadius(16)
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView(selectedCity: "Denver, CO")
        .environmentObject(FavoritesManager())
}
