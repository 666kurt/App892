import SwiftUI

struct MainContinentCardView: View {
    
    let continent: Continent
    
    var body: some View {
        Image(continent.image)
            .resizable()
            .scaledToFill()
            .frame(height: 140)
            .scaleEffect(CGSize(width: 1.2, height: 1.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                Text(continent.name)
                    .padding()
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white), alignment: .topLeading
            )
            .overlay(
                Text("Review")
                    .font(.subheadline)
                    .foregroundColor(.theme.text.textGreen)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding(), alignment: .bottomTrailing
            )
    }
}

#Preview {
    MainContinentCardView(continent: Continent(name: "Europe", continent: "europe", image: "europe"))
        .padding()
}
