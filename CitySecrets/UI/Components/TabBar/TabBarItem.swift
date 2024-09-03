import SwiftUI

struct TabBarItem: View {
    
    let image: String
    var screen: Screens
    @Binding var selectedScreen: Screens
    
    var body: some View {
        
        Image(systemName: image)
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(selectedScreen == screen
                             ? Color.accentColor
                             : Color.theme.text.textWhite)
            .padding()
            .background(
                Circle()
                    .foregroundColor(selectedScreen == screen
                                     ? Color.white
                                     : Color.clear)
            )
            .onTapGesture {
                selectedScreen = screen
            }
        
    }
}

#Preview {
    TabBarItem(image: "location.fill",
               screen: Screens(rawValue: "location.fill")!,
               selectedScreen: .constant(.main))
}
