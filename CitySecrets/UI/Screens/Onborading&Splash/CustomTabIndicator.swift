import SwiftUI

struct CustomTabIndicator: View {
    @Binding var currentTab: Int
    var numberOfTabs: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<numberOfTabs, id: \.self) { index in
                if index == currentTab {
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 8, height: 8)
                } else {
                    Circle()
                        .fill(Color(hex: "FFFFFF").opacity(0.14))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}

#Preview {
    CustomTabIndicator(currentTab: .constant(0), numberOfTabs: 2)
}
