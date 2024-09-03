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
        Continent(name: "North America", continent: "northAmerica", image: "northAmerica"),
        Continent(name: "South America", continent: "southAmerica", image: "southAmerica"),
        Continent(name: "Australia", continent: "australia", image: "australia")
    ]
}
