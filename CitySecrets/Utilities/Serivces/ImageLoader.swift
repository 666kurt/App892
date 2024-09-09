import Combine
import UIKit

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func loadImage(from url: String) {
        if let cachedImage = NSCache<NSString, UIImage>().object(forKey: url as NSString) {
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
                    NSCache<NSString, UIImage>().setObject(downloadedImage, forKey: url as NSString)
                    self.image = downloadedImage
                }
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
