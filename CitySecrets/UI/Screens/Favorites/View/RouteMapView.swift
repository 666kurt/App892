import SwiftUI
import MapKit

struct RouteMapView: View {
    
    @EnvironmentObject private var router: Router
    let start: Attraction
    let end: Attraction
    
    var body: some View {
        MapViewRepresentable(
            start: CLLocationCoordinate2D(latitude: start.coordinates.latitude,
                                          longitude: start.coordinates.longitude),
            end: CLLocationCoordinate2D(latitude: end.coordinates.latitude, 
                                        longitude: end.coordinates.longitude)
        )
        .edgesIgnoringSafeArea(.all)
        .onDisappear() {
            router.showPlaceSelection()
        }
    }
}

