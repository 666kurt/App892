import SwiftUI

struct MapScreen: View {
    
    let lat: Double
    let lon: Double
    
    @EnvironmentObject private var router: Router
    
    var body: some View {
        MapView(lat: lat, lon: lon)
            .overlay(dismissButton, alignment: .topLeading)
        
    }
}

extension MapScreen {
    
    private var dismissButton: some View {
        Image(systemName: "xmark.circle.fill")
            .resizable()
            .foregroundColor(.accentColor)
            .frame(width: 32, height: 32)
            .padding()
            .onTapGesture {
                router.dismissSheet()
            }
    }
    
}

#Preview {
    MapScreen(lat: 48.8584, lon: 2.2945)
        .environmentObject(Router.shared)
}
