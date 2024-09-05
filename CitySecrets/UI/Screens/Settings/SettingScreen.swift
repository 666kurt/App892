import SwiftUI

struct SettingScreen: View {
    var body: some View {
        VStack {
            
            SettingButtonView(title: "Share app", image: "square.and.arrow.up.fill")
            
            SettingButtonView(title: "Rate Us", image: "star.fill")
            
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
}

#Preview {
    SettingScreen()
}
