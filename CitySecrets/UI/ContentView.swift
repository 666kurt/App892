import SwiftUI

struct ContentView: View {
    
    @StateObject var router = Router.shared
    @StateObject var attractionViewModel = MainViewModel()
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                switch router.selectedScreen {
                case .main:
                    MainScreen()
                case .favorites:
                    FavoritesScreen()
                case .profile:
                    ProfileScreen()
                        .environmentObject(profileViewModel)
                }
                TabBarView(selectedScreen: $router.selectedScreen)
                    .offset(y: 5)
            }
            .ignoresSafeArea(.keyboard)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .colorScheme(.light)
        .environmentObject(router)
        .environmentObject(attractionViewModel)
    }
}

#Preview {
    ContentView()
}
