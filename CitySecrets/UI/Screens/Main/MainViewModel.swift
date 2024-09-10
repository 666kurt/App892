import Combine
import Foundation
import Firebase
import FirebaseDatabase

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
        let ref = Database.database().reference().child("attractions")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                print("Error: Could not fetch data from Firebase")
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Attraction].self, from: jsonData)
                DispatchQueue.main.async {
                    self.attraction = decodedData
                    self.loadFavorites()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
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
