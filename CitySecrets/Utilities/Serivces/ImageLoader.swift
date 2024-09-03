import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    private var cancellable: AnyCancellable?

    func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: imageURL)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.image = image
            }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
