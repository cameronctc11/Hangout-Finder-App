//
//  FavoritesManager.swift
//  Hangout Finder App
//
//  Created by McKenzie, Cameron - Student on 12/8/25.
//

import Foundation
import SwiftUI

final class FavoritesManager: ObservableObject {
    @Published var favorites: [String] = [] {
        didSet { saveFavorites() }
    }
    
    private let key = "saved_favorites"
    
    init() {
        loadFavorites()
    }
    
    func toggleFavorite(_ spot: String) {
        if favorites.contains(spot) {
            favorites.removeAll { $0 == spot }
        } else {
            favorites.append(spot)
        }
    }
    
    func isFavorite(_ spot: String) -> Bool {
        favorites.contains(spot)
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(favorites, forKey: key)
    }
    
    private func loadFavorites() {
        favorites = UserDefaults.standard.stringArray(forKey: key) ?? []
    }
}
