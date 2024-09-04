import SwiftUI

struct SegmentedControl: View {
    
    @Binding var selectedIndex: Int
    let options: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Category")
                .font(.title3.weight(.semibold))
                .foregroundColor(.black)
            HStack(spacing: 10) {
                ForEach(options.indices, id: \.self) { index in
                    ZStack(alignment: .bottom) {
                        Text(options[index])
                            .foregroundColor(selectedIndex == index
                                             ? .accentColor
                                             : .theme.text.textBlack)
                            
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 10)
                        
                        if selectedIndex == index {
                            Rectangle()
                               .frame(height: 1)
                               .foregroundColor(.accentColor)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.interactiveSpring()) {
                            selectedIndex = index
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SegmentedControl(selectedIndex: .constant(0), options: ["Historical", "Museums", "Galleries"])
}
