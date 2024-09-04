import SwiftUI

struct AttractionPopularCardView: View {
    
    let attraction: Attraction
    
    var body: some View {
        URLImageView(url: attraction.image)
            .frame(width: 170, height: 130)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(leftContent, alignment: .topLeading)
    }
}

extension AttractionPopularCardView {
    
    private var leftContent: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            NavigationLink {
                AttractionDetailView(attraction: attraction)
            } label: {
                Text("Preview")
                    .font(.footnote)
                    .foregroundColor(.theme.text.textGreen)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7.5)
                    .background(Color.white)
                    .clipShape(Capsule())
            }
            
            VStack(alignment: .leading) {
                Text(attraction.name)
                Text(attraction.country)
            }
            .font(.callout.weight(.semibold))
            .foregroundColor(.white)
        }
        .padding(8)
    }
}

#Preview {
    AttractionPopularCardView(attraction: Attraction.preview)
}
