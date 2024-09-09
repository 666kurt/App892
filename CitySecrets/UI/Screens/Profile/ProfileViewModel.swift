import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    @Published var name: String = "" {
        didSet {
            saveName()
        }
    }
    
    @Published var profileImage: UIImage? = nil {
        didSet {
            saveProfileImage()
        }
    }
    
    init() {
        self.name = loadName()
        self.profileImage = loadProfileImage()
    }
    
    private func saveName() {
        UserDefaults.standard.set(name, forKey: "userName")
    }
    
    private func loadName() -> String {
        return UserDefaults.standard.string(forKey: "userName") ?? ""
    }
    
    private func saveProfileImage() {
        guard let image = profileImage else { return }
        
        if let data = image.jpegData(compressionQuality: 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent("profileImage.jpg")
            try? data.write(to: filename)
            UserDefaults.standard.set(filename.path, forKey: "profileImagePath")
        }
    }
    
    private func loadProfileImage() -> UIImage? {
        let path = UserDefaults.standard.string(forKey: "profileImagePath")
        if let path = path {
            let imagePath = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: imagePath) {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
