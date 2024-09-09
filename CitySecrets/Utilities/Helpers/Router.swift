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
    case imagePicker
    
    var id: String {
        self.rawValue
    }
}

final class Router: ObservableObject {
    
    static let shared = Router()
    private init() {}
    
    @Published var selectedScreen: Screens = .main
    @Published var sheet: Sheet?
    @Published var placeSelection: Bool = false
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func showPlaceSelection() {
        placeSelection.toggle()
    }
    
    @ViewBuilder
    func build(sheet: Sheet, lat: Double = 0.0, lon: Double = 0.0, onImagePicked: @escaping (UIImage) -> Void = { _ in }) -> some View {
        switch sheet {
        case .map:
            AttractionMapView(lat: lat, lon: lon)
                .ignoresSafeArea()
        case .imagePicker:
            ImagePicker(onImagePicked: onImagePicked)
        }
    }
}
