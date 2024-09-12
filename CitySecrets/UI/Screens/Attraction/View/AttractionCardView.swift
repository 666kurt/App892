import SwiftUI
import SDWebImageSwiftUI

struct AttractionCardView: View {
    
    @EnvironmentObject private var mainViewModel: MainViewModel
    let attraction: Attraction
    @State private var isLoading: Bool = true
    
    var body: some View {
        WebImage(url: URL(string: attraction.image)) { image in
            image
                .resizable()
                .frame(height: UIScreen.main.bounds.width * 0.4)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(cardTitle, alignment: .topLeading)
                .overlay(timeView, alignment: .bottomLeading)
                .overlay(reviewButton, alignment: .bottomTrailing)
                .overlay(cartButton, alignment: .topTrailing)
        } placeholder: {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: UIScreen.main.bounds.width * 0.5)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .animatePlaceholder(isLoading: $isLoading)
        }
    }
}

// MARK: subviews

extension AttractionCardView {
    
    private var cardTitle: some View {
        VStack(alignment: .leading) {
            Text(attraction.name)
                .font(.callout.weight(.semibold))
            Text(attraction.country)
                .font(.callout)
        }
        .padding()
        .foregroundColor(.white)
    }
    
    private var cartButton: some View {
        Circle()
            .foregroundColor(.theme.background.bgGray)
            .frame(width: 43, height: 43)
            .overlay(
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(mainViewModel.favoritesStatus[attraction.name] == true
                        ? .red
                        : .accentColor
                    )
            )
            .onTapGesture {
                withAnimation(.easeInOut) {
                    mainViewModel.toggleFavorite(for: attraction)
                }
            }
            .padding()
    }
    
    private var timeView: some View {
        HStack(spacing: 10) {
            CartTimeView(time: separateTime(for: attraction.hours)[0])
            CartTimeView(time: separateTime(for: attraction.hours)[1])
        }
        .padding()
    }
    
    private var reviewButton: some View {
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
                .padding()
        }
    }

}

// MARK: additional reusable views

struct CartTimeView: View {
    
    let time: String
    
    var body: some View {
        Text(time)
            .padding(.horizontal, 10)
            .padding(.vertical, 7.5)
            .background(Color.theme.text.textWhite)
            .font(.footnote)
            .clipShape(Capsule())
    }
    
}

#Preview {
    AttractionCardView(attraction: Attraction.preview)
        .environmentObject(MainViewModel())
    .padding()
}
