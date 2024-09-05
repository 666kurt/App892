import Combine
import UIKit

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func loadImage(from url: String) {
        if let cachedImage = ImageCache.shared.object(forKey: url as NSString) {
            self.image = cachedImage
            return
        }

        guard let imageURL = URL(string: url) else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: imageURL)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] downloadedImage in
                guard let self = self else { return }
                
                if let downloadedImage = downloadedImage {
                    ImageCache.shared.setObject(downloadedImage, forKey: url as NSString)
                    self.image = downloadedImage
                }
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
