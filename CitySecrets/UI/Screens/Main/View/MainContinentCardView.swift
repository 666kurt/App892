import SwiftUI

struct MainContinentCardView: View {
    
    let continent: Continent
    
    var body: some View {
        Image(continent.image)
            .resizable()
            .scaledToFill()
            .frame(height: UIScreen.main.bounds.width * 0.4)
            .scaleEffect(CGSize(width: 1.2, height: 1.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                Text(continent.name)
                    .padding()
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white), alignment: .topLeading
            )
    }
}

#Preview {
    MainContinentCardView(continent: Continent(name: "Europe", continent: "europe", image: "europe"))
        .padding()
}
