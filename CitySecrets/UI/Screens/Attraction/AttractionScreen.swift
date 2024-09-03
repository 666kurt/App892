import SwiftUI

struct AttractionScreen: View {
    
    @EnvironmentObject var attractionViewModel: MainViewModel
    var continent: String
    
    var body: some View {
        VStack {
          
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 10) {
                    ForEach(attractionViewModel.filteredAttractions(for: continent), id: \.self) { attraction in
                        AttractionCardView(attraction: attraction)
                    }
                }
            }
            
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.theme.text.textGreen)
                            Text(continent)
                        }
                    }
                }
            
        }
        .vstackModifier()
    }
}

#Preview {
    MainScreen()
        .environmentObject(MainViewModel())
}
