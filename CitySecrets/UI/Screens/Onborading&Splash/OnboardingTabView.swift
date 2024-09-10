import SwiftUI

struct OnboardingTabView: View {
    
    let image: String
    
    var body: some View {
        GeometryReader { geo in
            Image(image)
                .resizable()
                .frame(width: geo.size.width)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    OnboardingTabView(image: "onboarding1")
}
