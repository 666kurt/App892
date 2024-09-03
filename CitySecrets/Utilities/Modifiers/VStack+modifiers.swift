import SwiftUI

struct VStackModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 15)
    }
}

extension View {
    func vstackModifier() -> some View {
        self.modifier(VStackModifiers())
    }
}
