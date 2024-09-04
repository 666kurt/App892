import SwiftUI

struct CircleButton: View {
    
    let image: String
    let action: () -> Void
    
    var body: some View {
        Circle()
            .foregroundColor(.theme.background.bgGray)
            .frame(width: 43, height: 43)
            .overlay(
                Image(systemName: image)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.accentColor)
            )
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    CircleButton(image: "location.fill", action: {})
}
