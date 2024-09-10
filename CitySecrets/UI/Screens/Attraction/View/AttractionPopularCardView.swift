import SwiftUI
import SDWebImageSwiftUI

struct AttractionPopularCardView: View {
    
    let attraction: Attraction
    @State private var isLoading: Bool = true

    var body: some View {
        
        WebImage(url: URL(string: attraction.image)) { image in
            image
                .resizable()
                .frame(width: 170, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(leftContent, alignment: .topLeading)
        } placeholder: {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 170, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .animatePlaceholder(isLoading: $isLoading)
        }

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
