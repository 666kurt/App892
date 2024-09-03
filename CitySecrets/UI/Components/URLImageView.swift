import SwiftUI

struct URLImageView: View {
    @ObservedObject var imageLoader = ImageLoader()
    let placeholder: Image
    let url: String

    init(url: String, placeholder: Image = Image(systemName: "photo")) {
        self.placeholder = placeholder
        self.url = url
        self.imageLoader.loadImage(from: url)
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            placeholder
                .resizable()
                .scaledToFill()
        }
    }
}
