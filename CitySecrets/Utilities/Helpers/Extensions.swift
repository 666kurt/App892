import Foundation
import SwiftUI

// MARK: colors

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
    
    var components: (r: Double, g: Double, b: Double, a: Double) {
        
        typealias NativeColor = UIColor
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else { return (0,0,0,0) }
        
        return (Double(r), Double(g), Double(b), Double(a))
    }
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    struct TextColors {
        let textBlack = Color("textBlack")
        let textGreen = Color("textGreen")
        let textWhite = Color("textWhite")
    }
    
    struct BackgroundColors {
        let bgGray = Color("bgGray")
        let bgGreen = Color("bgGreen")
        let bgMediumGray = Color("bgMediumGray")
        let bgWhite = Color("bgWhite")
    }
    
    struct OtherColors {
        let separatorWhite = Color("separatorWhite")
        let separatorYellow = Color("separatorYellow")
    }
    
    let text = TextColors()
    let background = BackgroundColors()
    let other = OtherColors()
    
}

// MARK: string

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.dropFirst()
    }
}

// MARK: view

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
