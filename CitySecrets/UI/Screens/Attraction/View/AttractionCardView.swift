import SwiftUI

struct AttractionCardView: View {
    
    let attraction: Attraction
    
    var body: some View {
        URLImageView(url: attraction.image)
            .frame(height: 170)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(cardTitle, alignment: .topLeading)
            .overlay(cartButtons, alignment: .topTrailing)
            .overlay(timeView, alignment: .bottomLeading)
    }
}

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
    
    private var cartButtons: some View {
        HStack(spacing: 10) {
            CartButtonsView(image: "heart.fill", action: {})
            CartButtonsView(image: "location.fill", action: {})
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
    
    private func separateTime(for time: String) -> [String] {
        return time.components(separatedBy: "-")
    }
    
}

struct CartButtonsView: View {
    
    let image: String
    let action: () -> Void
    
    var body: some View {
        Circle()
            .foregroundColor(.white)
            .frame(width: 25, height: 25)
            .overlay(
                Image(systemName: image)
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.accentColor)
            )
            .onTapGesture {
                action()
            }
    }
}

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
    AttractionCardView(attraction: Attraction(name: "Eiffel Tower",
                                              country: "France",
                                              continent: "europe",
                                              coordinates: Attraction.Coordinates(latitude: 48.8606, longitude: 2.3376),
                                              description: "The Eiffel Tower is an iconic wrought-iron lattice tower in Paris, standing tall at 324 meters. It was designed by Gustave Eiffel and built for the 1889 World's Fair, marking the 100th anniversary of the French Revolution. The tower offers stunning panoramic views of Paris from its observation decks and is one of the most visited paid monuments in the world.",
                                              category: "historical building",
                                              image: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=2946&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                              hours: "09:30 AM - 11:45 PM"))
    .padding()
}
