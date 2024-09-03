import SwiftUI

struct TabBarView: View {
    
    @Binding var selectedScreen: Screens
    
    var body: some View {
        HStack {
            
            Spacer()
            
            TabBarItem(image: "location.fill",
                       screen: .main,
                       selectedScreen: $selectedScreen)
            Spacer()
            
            TabBarItem(image: "heart.fill",
                       screen: .favorites,
                       selectedScreen: $selectedScreen)
            
            Spacer()
            
            TabBarItem(image: "person.fill",
                       screen: .profile,
                       selectedScreen: $selectedScreen)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 7)
        .background(Color.accentColor.ignoresSafeArea())
    }
}

#Preview {
    TabBarView(selectedScreen: .constant(.main))
}
