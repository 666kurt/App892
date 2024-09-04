import Combine
import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var attraction: [Attraction] = []
    @Published var text: String = ""
    @Published var selectedIndex = 0
    
    init() {
        loadJSON()
    }
    
    func loadJSON() {
        if let url = Bundle.main.url(forResource: "attraction", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Attraction].self, from: data)
                DispatchQueue.main.async {
                    self.attraction = decodedData
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
    }
    
    func filteredAttractions(for continent: String, category: String?) -> [Attraction] {
        attraction.filter { $0.continent == continent &&
            (category == nil || $0.category == category) &&
            (text.isEmpty || $0.name.lowercased().contains(text.lowercased()))
        }
    }
    
    func recommendedAttractions(for continent: String) -> [Attraction] {
        attraction.filter { $0.continent == continent && $0.isRecommended }
    }
    
    var favoritesAttractions: [Attraction] {
        attraction.filter { $0.isFavorites }
    }
    
    func toggleFavorite(for attraction: Attraction) {
        if let index = self.attraction.firstIndex(where: { $0.name == attraction.name }) {
            self.attraction[index].isFavorites.toggle()
        }
    }
    
}
