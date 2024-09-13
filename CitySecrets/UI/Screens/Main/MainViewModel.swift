import Combine
import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var attraction: [Attraction] = []
    @Published var text: String = ""
    @Published var selectedIndex = 0
    @Published var favoritesStatus: [String: Bool] = [:]
    
    private let favoritesKey = "favoritesAttractions"
    
    init() {
        loadFromFirebase()
        loadFavorites()
    }
    
    // Загрузка данных из firebase
    func loadFromFirebase() {
        if let url = Bundle.main.url(forResource: "attraction", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                attraction = try decoder.decode([Attraction].self, from: data)
                print("Data successfully loaded from file!")
            } catch {
                print("Error loading data from file: \(error)")
            }
        } else {
            print("File not found!")
        }
    }
    
    // Сохранение избранных достопримечательностей
    func saveFavorites() {
        let favoriteNames = favoritesStatus.filter { $0.value }.map { $0.key }
        UserDefaults.standard.set(favoriteNames, forKey: favoritesKey)
    }
    
    // Загрузка избранных достопримечательностей
    func loadFavorites() {
        let favoriteNames = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        for name in favoriteNames {
            favoritesStatus[name] = true
        }
    }
    
    // Переключение избранного статуса
    func toggleFavorite(for attraction: Attraction) {
        if let currentStatus = favoritesStatus[attraction.name] {
            favoritesStatus[attraction.name] = !currentStatus
        } else {
            favoritesStatus[attraction.name] = true
        }
        saveFavorites()
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
        attraction.filter { favoritesStatus[$0.name] == true }
    }
    
    // Рекомендованные достопримечательности
    func recommendedAttractions(for continent: String) -> [Attraction] {
        attraction.filter { $0.continent == continent && $0.isRecommended }
    }
}
