import SwiftUI

struct ContentView: View {
    
    @StateObject var router = Router.shared
    @StateObject var attractionViewModel = MainViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            switch router.selectedScreen {
            case .main:
                MainScreen()
                    .environmentObject(attractionViewModel)
            case .favorites:
                FavoritesScreen()
            case .profile:
                ProfileScreen()
            }
            
            TabBarView(selectedScreen: $router.selectedScreen)
        }
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
}
