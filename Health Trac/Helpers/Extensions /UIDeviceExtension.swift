//
//  UIDeviceExtension.swift
//   Health Track
//


import AVFoundation
import UIKit

// MARK: - UIDEVICE
//==================
extension UIDevice {
    
        /// Returns `true` if the device has a notch
    static var hasNotch: Bool {
            guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
                return window.safeAreaInsets.top >= 44
        }

    static var size: CGSize {
        return UIScreen.main.bounds.size
    }

    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }

    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }

    @available(iOS 11.0, *)
    static var bottomSafeArea = UIApplication.shared.keyWindow!.safeAreaInsets.bottom

    @available(iOS 11.0, *)
    static let topSafeArea = UIApplication.shared.keyWindow!.safeAreaInsets.top

    static func vibrate() {
        let feedback = UIImpactFeedbackGenerator.init(style: UIImpactFeedbackGenerator.FeedbackStyle.heavy)
        feedback.prepare()
        feedback.impactOccurred()
    }
}
