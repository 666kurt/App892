import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var attractionViewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                searchBar
                countryScroll
            }
            .vstackModifier()
        }
    }
}

extension MainScreen {
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.theme.text.textBlack)
            
            TextField("Search", text: $attractionViewModel.text)
        }
        .padding(7)
        .frame(maxWidth: .infinity)
        .background(Color.theme.background.bgGray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.top)
        .padding(.bottom, 15)
    }
    
    private var countryScroll: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                Text("Select a continent")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
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
    }
}

#Preview {
    MainScreen()
        .environmentObject(MainViewModel())
}
