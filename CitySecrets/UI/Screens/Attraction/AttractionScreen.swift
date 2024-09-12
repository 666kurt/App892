import SwiftUI

struct AttractionScreen: View {
    
    @EnvironmentObject var attractionViewModel: MainViewModel
    var continent: String
    
    var body: some View {
        VStack(spacing: 20) {
            
            SearchBar(searchText: $attractionViewModel.text)
            
            SegmentedControl(selectedIndex: $attractionViewModel.selectedIndex,
                             options: ["Historical", "Museums", "Galleries"])
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Popular places")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.black)
                ScrollView(.horizontal, showsIndicators: true) {
                    LazyHStack(spacing: 10) {
                        ForEach(recommendedAttractions, id: \.self) { attraction in
                            AttractionPopularCardView(attraction: attraction)
                        }
                    }
                }
                .frame(height: 150)
            }
            
            attractionList
            
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.theme.text.textGreen)
                            Text(continent.capitalizeFirstLetter())
                                .font(.subheadline.weight(.semibold))
                        }
                    }
                }
            
        }
        .vstackModifier()
    }
}

extension AttractionScreen {
    
    private var attractionList: some View {
        ScrollView(showsIndicators: true) {
            LazyVStack(spacing: 10) {
                ForEach(filteredAttractions, id: \.self) { attraction in
                    AttractionCardView(attraction: attraction)
                }
            }
        }
        .padding(.bottom, 60)
    }
    
    private var filteredAttractions: [Attraction] {
        let categories = ["historical", "museum", "gallery"]
        let selectedCategory = categories[attractionViewModel.selectedIndex]
        return attractionViewModel.filteredAttractions(for: continent, category: selectedCategory)
    }
    
    private var recommendedAttractions: [Attraction] {
        attractionViewModel.recommendedAttractions(for: continent)
    }
    
}

#Preview {
    AttractionScreen(continent: "europe")
        .environmentObject(MainViewModel())
}
