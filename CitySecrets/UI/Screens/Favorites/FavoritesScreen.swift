import SwiftUI

struct FavoritesScreen: View {
    
    @EnvironmentObject private var mainViewModel: MainViewModel
    @EnvironmentObject private var router: Router
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                
                SearchBar(searchText: $mainViewModel.text)
                
                if mainViewModel.filteredFavoritesAttractions.isEmpty {
                    emptyView
                } else {
                    VStack(spacing: 20) {
                        routeImage
                        favoritesListView
                    }
                }
            }
            .vstackModifier()
            
            if (router.placeSelection) {
                RouteSelectionView()
                    .environmentObject(mainViewModel)
                    .environmentObject(router)
            }
        }
    }
}

extension FavoritesScreen {
    
    private var emptyView: some View {
        VStack(spacing: 16) {
            
            Spacer()
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 36, height: 36)
                .foregroundColor(.accentColor)
                .padding(.bottom, 10)
            Text("It's empty here now")
                .font(.title.weight(.bold))
            Text("Click on the heart icon to save places to\nyour wish list")
                .multilineTextAlignment(.center)
            
            Spacer()
            Spacer()
            Spacer()
        }
        .foregroundColor(.black)
    }
    
    private var favoritesListView: some View {
        ScrollView(showsIndicators: true) {
            LazyVStack(spacing: 10) {
                ForEach(mainViewModel.filteredFavoritesAttractions, id: \.self) { attraction in
                    AttractionCardView(attraction: attraction)
                }
            }
        }
        .padding(.bottom, 60)
    }
    
    private var routeImage: some View {
        ZStack {
            Image("routeImage")
                .resizable()
                .scaledToFit()
                .overlay(routeButton, alignment: .bottom)
        }
    }
    
    private var routeButton: some View {
        Text("Create a route")
            .padding(.horizontal, 17)
            .padding(.vertical, 7)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .clipShape(Capsule())
            .padding(.bottom, 13)
            .onTapGesture {
                router.showPlaceSelection()
            }
    }
    
}

#Preview {
    FavoritesScreen()
        .environmentObject(MainViewModel())
        .environmentObject(Router.shared)
}
