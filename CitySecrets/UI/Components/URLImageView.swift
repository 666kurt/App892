import SwiftUI

struct URLImageView: View {
    @ObservedObject var imageLoader = ImageLoader()
    let url: String
    @State private var isLoading: Bool = true

    init(url: String) {
        self.url = url
        self.imageLoader.loadImage(from: url)
    }

    var body: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .onAppear {
                        isLoading = false
                    }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .animatePlaceholder(isLoading: $isLoading)
            }
        }
        .onAppear {
            isLoading = true
        }
    }
}
