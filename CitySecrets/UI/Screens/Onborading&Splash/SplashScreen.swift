import SwiftUI

struct SplashScreen: View {
    
    @State private var progress: CGFloat = 0.0
    @State private var isActive: Bool = false
    @Binding var showOnboarding: Bool
    
    var body: some View {
        Image("splash")
            .resizable()
            .ignoresSafeArea()
        
            .onAppear {
                startLoading()
            }
            .fullScreenCover(isPresented: $isActive) {
                if showOnboarding {
                    OnboardingScreen(showOnboarding: $showOnboarding)
                } else {
                    ContentView()
                }
            }
    }
    
    func startLoading() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if progress < 100 {
                progress += 5
            } else {
                timer.invalidate()
                isActive = true
            }
        }
    }
}

#Preview {
    SplashScreen(showOnboarding: .constant(true))
}
