//
//  UIColorExtension.swift
//   Health Track
//


import Foundation
import UIKit

// UIColor Extension
extension UIColor {
    
    
    /// Creates a color object that generates its color data dynamically using the specified colors. For early SDKs creates light color.
    /// - Parameters:
    ///   - light: The color for light mode.
    ///   - dark: The color for dark mode.
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return dark
                }
                return light
            }
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
    
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat) {
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")
        assert(alpha >= 0 && alpha <= 1, "Invalid alpha component")
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    ///Returns the color based on the given R,G,B and alpha values
    class func colorRGB(r: Int, g: Int, b: Int, alpha: CGFloat = 1) -> UIColor {
        
        return UIColor(r: r, g: g, b: b, alpha: alpha)
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    ///Returns the color based on the given hex string
    class func colorHex(hexString: String) -> UIColor {
        
        var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
        
        if cString.hasPrefix("#") {
            
            cString = String(cString[cString.index(cString.startIndex, offsetBy: 1) ..< cString.endIndex])
            
            //substring(with: (cString.characters.index(cString.startIndex, offsetBy: 1) ..< cString.endIndex))
        }
        if (cString.count) != 6 {
            return UIColor.gray
        }
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    struct Green {
        static let fern = UIColor.colorHex(hexString: "0x6ABB72")
        static let mountainMeadow = UIColor.colorHex(hexString: "0x3ABB9D")
        static let chateauGreen = UIColor.colorHex(hexString: "0x4DA664")
        static let persianGreen = UIColor.colorHex(hexString: "0x2CA786")
    }
    
    struct Blue {
        static let pictonBlue = UIColor.colorHex(hexString: "0x5CADCF")
        static let mariner = UIColor.colorHex(hexString: "0x3585C5")
        static let curiousBlue = UIColor.colorHex(hexString: "0x4590B6")
        static let denim = UIColor.colorHex(hexString: "0x2F6CAD")
        static let chambray = UIColor.colorHex(hexString: "0x485675")
        static let blueWhale = UIColor.colorHex(hexString: "0x29334D")
    }
    
    struct Violet {
        static let wisteria = UIColor.colorHex(hexString: "0x9069B5")
        static let blueGem = UIColor.colorHex(hexString: "0x533D7F")
    }
    
    struct Yellow {
        static let energy = UIColor.colorHex(hexString: "0xF2D46F")
        static let turbo = UIColor.colorHex(hexString: "0xF7C23E")
    }
    
    struct Orange {
        static let neonCarrot = UIColor.colorHex(hexString: "0xF79E3D")
        static let sun = UIColor.colorHex(hexString: "0xEE7841")
    }
    
    struct Red {
        static let terraCotta = UIColor.colorHex(hexString: "0xE66B5B")
        static let valencia = UIColor.colorHex(hexString: "0xCC4846")
        static let cinnabar = UIColor.colorHex(hexString: "0xDC5047")
        static let wellRead = UIColor.colorHex(hexString: "0xB33234")
    }
    
    struct Gray {
        static let almondFrost = UIColor.colorHex(hexString: "0xA28F85")
        static let whiteSmoke = UIColor.colorHex(hexString: "0xEFEFEF")
        static let iron = UIColor.colorHex(hexString: "0xD1D5D8")
        static let ironGray = UIColor.colorHex(hexString: "0x75706B")
    }
    
    static var random: UIColor {
        return UIColor(red: .random(in: 0...0.6),
                       green: .random(in: 0...0.6),
                       blue: .random(in: 0...0.6),
                       alpha: 1.0)
    }
}
