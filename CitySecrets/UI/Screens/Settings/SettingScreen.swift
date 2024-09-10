import SwiftUI
import StoreKit

struct SettingScreen: View {
    var body: some View {
        VStack {
            
            SettingButtonView(title: "Share app", image: "square.and.arrow.up.fill", action: shareApp)
            
            SettingButtonView(title: "Rate Us", image: "star.fill", action: rateApp)
            
        }
        .vstackModifier()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .font(.headline)
                    .foregroundColor(.accentColor)
            }
        }
    }
    
    private func shareApp() {
        guard let urlShare = URL(string: "https://apps.apple.com/app/365-city-secrets/id6670791355") else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
    private func rateApp() {
        guard let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
              print("UNABLE TO GET CURRENT SCENE")
              return
        }
        SKStoreReviewController.requestReview(in: currentScene)
    }
}

#Preview {
    SettingScreen()
}
