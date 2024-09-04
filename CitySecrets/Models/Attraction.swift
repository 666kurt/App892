import Foundation

struct Attraction: Codable, Hashable {
    var name: String
    var country: String
    var continent: String
    var coordinates: Coordinates
    var description: String
    var category: String
    var image: String
    var isRecommended: Bool
    var isFavorites: Bool
    var hours: String
    
    struct Coordinates: Codable, Hashable {
        var latitude: Double
        var longitude: Double
    }
    
    static var preview: Attraction {
        Attraction(name: "Eiffel Tower",
                   country: "France",
                   continent: "europe",
                   coordinates: Attraction.Coordinates(latitude: 48.8606, longitude: 2.3376),
                   description: "The Eiffel Tower is an iconic wrought-iron lattice tower in Paris, standing tall at 324 meters. It was designed by Gustave Eiffel and built for the 1889 World's Fair, marking the 100th anniversary of the French Revolution. The tower offers stunning panoramic views of Paris from its observation decks and is one of the most visited paid monuments in the world.",
                   category: "historical building",
                   image: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=2946&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                   isRecommended: true, 
                   isFavorites: false,
                   hours: "09:30 AM - 11:45 PM")
    }
}
