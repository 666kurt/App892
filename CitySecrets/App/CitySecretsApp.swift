import SwiftUI

@main
struct CitySecretsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State private var showOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding") == false

    
    var body: some Scene {
        WindowGroup {
            SplashScreen(showOnboarding: $showOnboarding)

        }
    }
}
