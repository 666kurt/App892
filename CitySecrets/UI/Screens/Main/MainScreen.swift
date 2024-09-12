import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var attractionViewModel: MainViewModel
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 15) {
                countryScroll
                    .navigationTitle("Select a continent")
                    .navigationBarTitleDisplayMode(.inline)
            
            }
            .vstackModifier()
        }
        
    }
}

// MARK: subviews

extension MainScreen {
    
    private var countryScroll: some View {
        ScrollView(showsIndicators: true) {
            LazyVStack(spacing: 8) {
                ForEach(Continent.countryData, id: \.id) { continent in
                    NavigationLink {
                        AttractionScreen(continent: continent.continent)
                            .environmentObject(attractionViewModel)
                    } label: {
                        MainContinentCardView(continent: continent)
                    }
                }
            }
        }
        .padding(.bottom, 60)
    }
}

#Preview {
    MainScreen()
        .environmentObject(MainViewModel())
}
