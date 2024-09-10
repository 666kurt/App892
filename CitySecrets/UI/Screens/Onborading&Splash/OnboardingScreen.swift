import SwiftUI

struct OnboardingScreen: View {
    
    @Binding var showOnboarding: Bool
    @State private var currentTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                OnboardingTabView(image: "onboarding1").tag(0)
                OnboardingTabView(image: "onboarding2").tag(1)
                OnboardingTabView(image: "onboarding3").tag(2)
            }
             
            VStack(spacing: 22) {
                Button(action: {
                    if currentTab < 2 {
                        currentTab += 1
                    } else {
                        showOnboarding = false
                        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                    }
                }, label: {
                    Text("Next")
                        .padding(.vertical, 17)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 15)
                })

                CustomTabIndicator(currentTab: $currentTab,
                                   numberOfTabs: 3)
            }
        }
    }
}



#Preview {
    OnboardingScreen(showOnboarding: .constant(true))
}
