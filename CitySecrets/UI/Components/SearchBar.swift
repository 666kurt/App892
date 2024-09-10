import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty
                                 ? .theme.text.textBlack 
                                 : .accentColor
                )
            
            TextField("Search", text: $searchText)
            
            Spacer()
            
            Image(systemName: "xmark.circle")
                .foregroundColor(searchText.isEmpty
                                 ? .theme.text.textBlack
                                 : .red
                )
                .onTapGesture {
                    searchText = ""
                }
            
        }
        .padding(7)
        .frame(maxWidth: .infinity)
        .background(Color.theme.background.bgGray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.top)
        .onDisappear() {
            searchText = ""
        }
    }
}

#Preview {
    SearchBar(searchText: .constant("dfgs"))
        .padding()
}
