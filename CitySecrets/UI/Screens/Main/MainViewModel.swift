import Combine
import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var attraction: [Attraction] = []
    @Published var text: String = ""
    
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
    
    func filteredAttractions(for continent: String) -> [Attraction] {
        return attraction.filter { $0.continent == continent }
    }
    
}
