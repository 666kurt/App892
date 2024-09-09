import SwiftUI

struct RouteSelectionView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var router: Router
    
    @State private var selectedStart: Attraction?
    @State private var selectedEnd: Attraction?
    
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        VStack {
            HStack {
                Text("Select start place")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Picker("", selection: $selectedStart) {
                    Text("None").tag(nil as Attraction?)
                    ForEach(mainViewModel.favoritesAttractions, id: \.self) { place in
                        Text(place.name).tag(place as Attraction?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("Select end places")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Picker("", selection: $selectedEnd) {
                    Text("None").tag(nil as Attraction?)
                    ForEach(mainViewModel.favoritesAttractions, id: \.self) { place in
                        Text(place.name).tag(place as Attraction?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if let start = selectedStart, let end = selectedEnd {
                NavigationLink {
                    RouteMapView(start: start, end: end)
                } label: {
                    Text("Start")
                        .padding()
                        .font(.body.weight(.medium))
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(.accentColor)
                        .cornerRadius(12)
                }
            } else {
                Text("Select places")
                    .padding()
                    .font(.body.weight(.medium))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.accentColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 15)
        .offset(y: offsetY)
        .onAppear {
            withAnimation(.spring()) {
                offsetY = -40
            }
        }
    }
}

#Preview {
    RouteSelectionView()
        .environmentObject(Router.shared)
        .environmentObject(MainViewModel())
}
