import Foundation

enum Screens: String, Identifiable {
    case main = "location.fill"
    case favorites = "heart.fill"
    case profile = "person.fill"
    
    var id: String {
        self.rawValue
    }
}

final class Router: ObservableObject {
    
    static let shared = Router()
    private init() {}
    
    @Published var selectedScreen: Screens = .main
    
}
