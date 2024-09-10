import SwiftUI

struct SettingButtonView: View {
    
    let title: String
    let image: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: image)
                .font(.system(size: 20))
            Text(title)
                .font(.subheadline.weight(.semibold))
        }
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity)
        .background(Color.accentColor)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    SettingButtonView(title: "Share app", image: "square.and.arrow.up.fill", action: {})
        .padding()
}
