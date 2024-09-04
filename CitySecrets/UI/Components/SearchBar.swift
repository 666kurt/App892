import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.theme.text.textBlack)
            
            TextField("Search", text: $searchText)
        }
        .padding(7)
        .frame(maxWidth: .infinity)
        .background(Color.theme.background.bgGray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.top)
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
