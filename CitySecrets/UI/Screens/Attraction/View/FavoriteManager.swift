import SwiftUI

struct FavoriteManager {
    private let favoritesKey = "favoritesAttractions"

    func isFavorite(attraction: Attraction) -> Bool {
        let favoriteNames = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        return favoriteNames.contains(attraction.name)
    }

    func toggleFavorite(attraction: Attraction) {
        var favoriteNames = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        if let index = favoriteNames.firstIndex(of: attraction.name) {
            favoriteNames.remove(at: index)
        } else {
            favoriteNames.append(attraction.name)
        }
        UserDefaults.standard.set(favoriteNames, forKey: favoritesKey)
    }
}
