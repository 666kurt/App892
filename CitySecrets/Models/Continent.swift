import Foundation

struct Continent: Identifiable {
    var id = UUID()
    let name: String
    let continent: String
    let image: String
    
    static let countryData: [Continent] = [
        Continent(name: "Europe", continent: "europe", image: "europe"),
        Continent(name: "Asia", continent: "asia", image: "asia"),
        Continent(name: "Africa", continent: "africa", image: "africa"),
        Continent(name: "America", continent: "america", image: "northAmerica"),
    ]
}
