import SwiftUI
import MapKit

struct MapView: View {
    
    private var lat: Double
    private var lon: Double
    
    private let initialLatitudinalMetres: Double = 500
    private let initialLongitudinalMetres: Double = 500
    
    @State private var span: MKCoordinateSpan?
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
    private var region: MKCoordinateRegion {
        let centre = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        if let span = span {
            return MKCoordinateRegion(center: centre, span: span)
        } else {
            return MKCoordinateRegion(center: centre, latitudinalMeters: initialLatitudinalMetres, longitudinalMeters: initialLongitudinalMetres)
        }
    }
    
    var body: some View {
        Map(coordinateRegion: .constant(region))
    }
}

#Preview {
    MapView(lat: 48.8584, lon: 2.2945)
}
