import Foundation
import SwiftUI

enum Screens: String, Identifiable {
    case main
    case favorites
    case profile
    
    var id: String {
        self.rawValue
    }
}

enum Sheet: String, Identifiable {
    case map
    
    var id: String {
        self.rawValue
    }
}

final class Router: ObservableObject {
    
    static let shared = Router()
    private init() {}
    
    @Published var navigationPath = Path()
    @Published var selectedScreen: Screens = .main
    @Published var sheet: Sheet?
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    @ViewBuilder
    func build(sheet: Sheet, lat: Double, lon: Double) -> some View {
        switch sheet {
        case .map:
            MapScreen(lat: lat, lon: lon)
                .ignoresSafeArea()
        }
    }
    
}
