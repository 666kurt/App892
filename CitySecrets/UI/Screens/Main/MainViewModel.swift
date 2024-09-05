import Combine
import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var attraction: [Attraction] = []
    @Published var text: String = ""
    @Published var selectedIndex = 0
    
    private let favoritesKey = "favoritesAttractions"

    init() {
        loadJSON()
        loadFavorites()
    }
    
    // Загрузка данных из JSON
    func loadJSON() {
        if let url = Bundle.main.url(forResource: "attraction", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Attraction].self, from: data)
                DispatchQueue.main.async {
                    self.attraction = decodedData
                    self.loadFavorites()
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
    }
    
    // Сохранение избранных достопримечательностей
    func saveFavorites() {
        let favoriteNames = attraction.filter { $0.isFavorites }.map { $0.name }
        UserDefaults.standard.set(favoriteNames, forKey: favoritesKey)
    }
    
    // Загрузка избранных достопримечательностей
    func loadFavorites() {
        let favoriteNames = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        for (index, attraction) in attraction.enumerated() {
            if favoriteNames.contains(attraction.name) {
                self.attraction[index].isFavorites = true
            } else {
                self.attraction[index].isFavorites = false
            }
        }
    }
    
    // Переключение избранного статуса
    func toggleFavorite(for attraction: Attraction) {
        if let index = self.attraction.firstIndex(where: { $0.name == attraction.name }) {
            self.attraction[index].isFavorites.toggle()
            saveFavorites()
        }
    }
    
    // Фильтр всех достопримечательностей
    func filteredAttractions(for continent: String, category: String?) -> [Attraction] {
        attraction.filter { $0.continent == continent &&
            (category == nil || $0.category == category) &&
            (text.isEmpty || $0.name.lowercased().contains(text.lowercased()))
        }
    }
    
    // Фильтр избранных достопримечательностей с учетом поиска
    var filteredFavoritesAttractions: [Attraction] {
        favoritesAttractions.filter { attraction in
            text.isEmpty || attraction.name.lowercased().contains(text.lowercased())
        }
    }
    
    // Избранные достопримечательности
    var favoritesAttractions: [Attraction] {
        attraction.filter { $0.isFavorites }
    }
    
    // Рекомендованные достопримечательности
    func recommendedAttractions(for continent: String) -> [Attraction] {
        attraction.filter { $0.continent == continent && $0.isRecommended }
    }
}
