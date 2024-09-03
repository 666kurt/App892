import Foundation

struct Attraction: Codable, Hashable {
    var name: String
    var country: String
    var continent: String
    var coordinates: Coordinates
    var description: String
    var category: String
    var image: String
    var hours: String
    
    struct Coordinates: Codable, Hashable {
        var latitude: Double
        var longitude: Double
    }
}
