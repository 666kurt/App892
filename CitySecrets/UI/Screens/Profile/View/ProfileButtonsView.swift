import SwiftUI

struct ProfileButtonsView: View {
    
    let title: String
    let image: String
    let url: String
    let isLink: Bool
    
    var body: some View {
        
        if isLink {
            Link(destination: URL(string: url)!, label: {
                content
            })

        } else {
            NavigationLink(destination: {
                SettingScreen()
            }, label: {
                content
            })
        }
    }
}

extension ProfileButtonsView {
    
    private var content: some View {
        HStack(spacing: 15) {
            Image(systemName: image)
                .font(.system(size: 20))
            Text(title)
                .font(.system(size: 16, weight: .medium))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 20))
            
        }
        .padding(15)
        .foregroundColor(.accentColor)
        .background(Color.theme.background.bgGray)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .theme.background.bgMediumGray,
                radius: 2, y: 2)
    }
    
}

#Preview {
    ProfileButtonsView(title: "Contact us",
                       image: "bubble.fill",
                       url: "https://google.com", isLink: true)
    .padding()
}
