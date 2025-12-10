//
//  FavoritesView.swift
//  Hangout Finder App
//
//  Created by McKenzie, Cameron - Student on 12/5/25.
//

import SwiftUI

let spotImages: [String: String] = [
    "Mountain Brew Café": "https://images.unsplash.com/photo-1509042239860-f550ce710b93",
    "Golden Hour Café": "https://images.unsplash.com/photo-1505483531331-40c2b1381c79",
    "Venice Boardwalk": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e"
]

struct FavoriteCardView: View {
    let spot: String
    
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var imageURL: String? {
        spotImages[spot]
    }
    
    var body: some View {
        HStack(spacing: 14) {
            AsyncImage(url: imageURL != nil ? URL(string: imageURL!) : nil) { phase in
                switch phase {
                case .empty:
                    Color.gray.opacity(0.3)
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure(_):
                    Color.gray.opacity(0.3)
                @unknown default:
                    Color.gray.opacity(0.3)
                }
            }
            .frame(width: 70, height: 70)
            .clipped()
            .cornerRadius(14)
            
            Text(spot)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                withAnimation {
                    favoritesManager.toggleFavorite(spot)
                }
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.white.opacity(0.25))
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var body: some View {
        ZStack {
            Color("BGColor")
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("Your Favorites ❤️")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                if favoritesManager.favorites.isEmpty {
                    Spacer()
                    Text("No favorites yet")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.headline)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(favoritesManager.favorites, id: \.self) { spot in
                                FavoriteCardView(spot: spot)
                            }
                        }
                        .padding(.top)
                    }
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesManager())
}
