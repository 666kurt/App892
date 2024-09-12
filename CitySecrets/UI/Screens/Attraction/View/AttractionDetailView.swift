import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct AttractionDetailView: View {
    
    let attraction: Attraction
    @EnvironmentObject var router: Router
    @State private var isLoading: Bool = true
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                
                WebImage(url: URL(string: attraction.image)) { image in
                    image
                        .resizable()
                        .frame(width: geo.size.width, height: geo.size.height * 0.5)
                        .ignoresSafeArea(edges: .top)
                        .overlay(timeView, alignment: .bottomLeading)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .animatePlaceholder(isLoading: $isLoading)
                }

                VStack(spacing: 25) {
                    HStack {
                        titleView
                        Spacer()
                        CircleButton(image: "location.fill", action: {
                            router.present(sheet: .map)
                        })
                    }
                    contentView
                }
                .padding(.horizontal, 15)
                .padding(.top, 40)
                .background(Color.white)
                .cornerRadius(40, corners: [.topLeft, .topRight])
                .padding(.top, geo.size.height * 0.4)
            }
            .ignoresSafeArea()
            .sheet(item: $router.sheet) { sheet in
                router.build(sheet: sheet,
                             lat: attraction.coordinates.latitude,
                             lon: attraction.coordinates.longitude)
            }
        }
    }
}

// MARK: subviews

extension AttractionDetailView {
    
    private var titleView: some View {
        VStack(alignment: .leading) {
            Text(attraction.name)
                .font(.title.weight(.bold))
            Text(attraction.country)
                .font(.title3.weight(.semibold))
        }
        .foregroundColor(.black)
    }
    
    private var contentView: some View {
        ScrollView(showsIndicators: true) {
            Text(attraction.description)
                .foregroundColor(.black)
                .font(.footnote)
            
            MapView(lat: attraction.coordinates.latitude, lon: attraction.coordinates.longitude)
                .frame(height: 180)
                .cornerRadius(12)
        }
    }
    
    private var timeView: some View {
        HStack(spacing: 10) {
            CartTimeView(time: separateTime(for: attraction.hours)[0])
            CartTimeView(time: separateTime(for: attraction.hours)[1])
        }
        .padding()
        .offset(y: -70)
    }
}

#Preview {
    AttractionDetailView(attraction: Attraction.preview)
        .environmentObject(Router.shared)
}



