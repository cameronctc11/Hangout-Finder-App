//
//  DetailView.swift
//  Hangout Finder App
//
//  Created by McKenzie, Cameron - Student on 12/1/25.
//

import SwiftUI
import MapKit

struct HangoutLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct DetailView: View {
    
    var spotName: String
    var city: String
    var category: String
    var coordinate: CLLocationCoordinate2D
    
    @State private var funRating: Int = Int.random(in: 3...5)
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    let spotImageURLs: [String: String] = [
        "Mountain Brew Café": "https://images.unsplash.com/photo-1509042239860-f550ce710b93",
        "Golden Hour Café": "https://images.unsplash.com/photo-1554118811-1e0d58224f24",
        "Rainy Day Café": "https://images.unsplash.com/photo-1521017432531-fbd92d768814",
        "Sunset Café": "https://images.unsplash.com/photo-1511920170033-f8396924c348",
        "Red Rocks Park": "https://images.unsplash.com/photo-1505842465776-3bdddb6be6ae",
        "City Park Picnic": "https://images.unsplash.com/photo-1508609349937-5ec4ae374ebf",
        "Cherry Creek Trail": "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
        "Union Station Patio": "https://images.unsplash.com/photo-1494526585095-c41746248156"
    ]
    
    let reviewImages: [String: [String]] = [
        "Mountain Brew Café": [
            "https://images.unsplash.com/photo-1541544181070-cf0ffed0e3c5",
            "https://images.unsplash.com/photo-1542831371-d531d36971e6",
            "https://images.unsplash.com/photo-1527169402691-a0b9d9b1b2b0"
        ],
        "Golden Hour Café": [
            "https://images.unsplash.com/photo-1558021212-51b6b24f64b1",
            "https://images.unsplash.com/photo-1551963831-b3b1ca40c98e",
            "https://images.unsplash.com/photo-1541696432-82c6da8ce7bf"
        ]
    ]
    
    // MARK: - Map Region
    @State private var region: MKCoordinateRegion
    
    init(spotName: String, city: String, category: String, coordinate: CLLocationCoordinate2D) {
        self.spotName = spotName
        self.city = city
        self.category = category
        self.coordinate = coordinate
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        ))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 24) {
                    // Main Image
                    if let imageURL = spotImageURLs[spotName], let url = URL(string: imageURL) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(height: 280)
                        .clipped()
                        .cornerRadius(28)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    
                    VStack(alignment: .leading, spacing: 14) {
                        // Title + Favorite Button
                        HStack {
                            Text(spotName)
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            Button {
                                withAnimation(.spring()) {
                                    favoritesManager.toggleFavorite(spotName)
                                }
                            } label: {
                                Image(systemName: favoritesManager.isFavorite(spotName) ? "heart.fill" : "heart")
                                    .foregroundColor(.red)
                                    .font(.title2)
                            }
                        }
                        
                        Text("\(category) • \(city)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 4) {
                            ForEach(0..<5) { i in
                                Image(systemName: i < funRating ? "star.fill" : "star")
                                    .foregroundColor(Color("ButtonColor"))
                            }
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(reviewImages[spotName] ?? [], id: \.self) { imgURL in
                                    if let url = URL(string: imgURL) {
                                        AsyncImage(url: url) { image in
                                            image.resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Color.gray.opacity(0.3)
                                        }
                                        .frame(width: 90, height: 90)
                                        .clipped()
                                        .cornerRadius(14)
                                        .overlay(RoundedRectangle(cornerRadius: 14)
                                            .stroke(Color.white.opacity(0.5), lineWidth: 1))
                                        .shadow(color: .black.opacity(0.25), radius: 4)
                                    }
                                }
                            }
                        }
                        
                        Text("This is one of the most loved \(category.lowercased()) spots in \(city). People come here to relax, take photos, and hang out with friends. It’s perfect for casual plans and fun spontaneous trips.")
                            .font(.body)
                            .padding(.top, 6)
                        
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                            Text("123 Main Street, \(city)")
                        }
                        .font(.caption)
                        .foregroundColor(.gray)
                        
                        Button {
                            favoritesManager.toggleFavorite(spotName)
                        } label: {
                            Text(favoritesManager.isFavorite(spotName) ? "Saved ❤️" : "Add to Favorites")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("ButtonColor"))
                                .foregroundColor(.white)
                                .cornerRadius(18)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.25))
                    .cornerRadius(26)
                    .padding(.horizontal)
                    
//                    Map(coordinateRegion: $region, annotationItems: [HangoutLocation(name: spotName, coordinate: coordinate)]) { location in
////                        MapAnnotation(coordinate: location.coordinate) {
////                            Image(systemName: "mappin.circle.fill")
////                                .foregroundColor(.red)
////                                .font(.title)
////                                .shadow(radius: 5)
//                        Marker("", coordinate: coordinate)
//                        }
//                    }
//                    .frame(height: 300)
//                    .cornerRadius(20)
//                    .padding(.horizontal)
                }
            }
            HStack {
                Spacer()
                NavigationLink(destination: FavoritesView().environmentObject(favoritesManager)) {
                    VStack {
                        Image(systemName: "heart.fill")
                            .font(.title2)
                        Text("Favorites")
                            .font(.caption)
                    }
                    .foregroundColor(.red)
                }
                Spacer()
            }
            .padding()
            .background(Color.white.opacity(0.2))
        }
        .background(Color("BGColor"))
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(
        spotName: "Mountain Brew Café",
        city: "Denver, CO",
        category: "Cafe",
        coordinate: CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903)
    )
    .environmentObject(FavoritesManager())
}
