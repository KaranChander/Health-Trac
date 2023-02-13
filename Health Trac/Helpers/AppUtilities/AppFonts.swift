//
//  AppFonts.swift
//   Health Track


import Foundation
import UIKit

enum AppFonts: String {
    case Montserrat_Semibold = "Montserrat-Semibold"
    case Montserrat_Black = "Montserrat-Black"
    case Montserrat_Bold = "Montserrat-Bold"
    case Montserrat_ExtraBold = "Montserrat-ExtraBold"
    case Montserrat_ExtraLight = "Montserrat-ExtraLight"
    case Montserrat_Heavy = "Montserrat-Heavy"
    case Montserrat_Italic = "Montserrat-Italic"
    case Montserrat_Light = "Montserrat-Light"
    case Montserrat_Medium = "Montserrat-Medium"
    case Montserrat_SemiBold = "Montserrat-SemiBold"
    case Montserrat_Thin = "Montserrat-Thin"
    case Montserrat_Regular = "Montserrat-Regular"
}

extension AppFonts {
    func withSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }

    func withDefaultSize() -> UIFont {
        return UIFont(name: self.rawValue, size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
    }

}
