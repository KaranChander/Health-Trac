//
//  MultipleExtensions.swift
//   Health Track
//


import Foundation
import UIKit
import Photos

extension PHAsset {

    func requestAVAsset() -> AVAsset? {
        // We only want videos here
        guard self.mediaType == .video else { return nil }
        // Create your semaphore and allow only one thread to access it
        let semaphore = DispatchSemaphore.init(value: 1)
        let imageManager = PHImageManager()
        var avAsset: AVAsset?
        // Lock the thread with the wait() command
        semaphore.wait()
        // Now go fetch the AVAsset for the given PHAsset
        imageManager.requestAVAsset(forVideo: self, options: nil) { (asset, _, _) in
            // Save your asset to the earlier place holder
            avAsset = asset
            // We're done, let the semaphore know it can unlock now
            semaphore.signal()
        }

        return avAsset
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            printDebug(error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension CGPoint {

    /// Return false if x or y is negative
    var isValid: Bool {

        if self.x < 0 || self.y < 0 {
            return false
        }
        return true
    }
}

extension UITextView {

    ///Returns Number of Lines
    public var numberOfLines: Int {
        let layoutManager = self.layoutManager
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var lineRange: NSRange = NSRange(location: 0, length: 1)
        var index = 0
        var numberOfLines = 0

        while index < numberOfGlyphs {
            layoutManager.lineFragmentRect(
                forGlyphAt: index, effectiveRange: &lineRange
            )
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }
        return numberOfLines
    }
}

struct GradientPoint {
    var location: NSNumber
    var color: UIColor
}

extension UINavigationController {

    /// Set gradient background color on the navigation bar.
    func setBarBackground(gradientColors: [GradientPoint], isHorizontal: Bool) {

        let img = UIImage(size: CGSize(width: UIScreen.main.bounds.width,
                                       height: self.navigationBar.frame.height),
                          gradientPoints: gradientColors, isHorizontal: isHorizontal)

        self.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        self.navigationBar.barTintColor = .clear
        self.navigationBar.backgroundColor = .clear

    }

    /// Set background color on the navigation bar.
    func setBarBackground(color: UIColor) {
        if color.cgColor.alpha < 1 {
            self.navigationBar.setBackgroundImage(UIImage(color: color),
                                                  for: UIBarMetrics.default)
            self.navigationBar.barTintColor = .clear
            self.navigationBar.backgroundColor = .clear
        } else {
            self.navigationBar.barTintColor = color
            self.navigationBar.backgroundColor = color
            self.navigationBar.setBackgroundImage(nil, for: .default)
        }
    }

    /// Set background image on the navigation bar.
    func setBarBackground(image: UIImage) {
        self.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
    }

    /// Set shadow color for the navigation bar.
    func setBarShadow(color: UIColor) {
        self.navigationBar.shadowImage = UIImage(color: color)
    }

    /// Set shadow image for the navigation bar.
    func setBarShadow(image: UIImage) {
        self.navigationBar.shadowImage = image
    }
}

extension UIViewController {

    /// Set attributed title for the navigation bar.
    func setAttributedTitle(with alignment: NSTextAlignment = .natural, title: NSAttributedString) {
        let titleLabel = UILabel()
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 0
        titleLabel.attributedText = title
        titleLabel.textAlignment = alignment
        if alignment != .justified && alignment != .natural {
            titleLabel.frame.size.width = UIScreen.main.bounds.width
        } else {
            titleLabel.frame.size = titleLabel.intrinsicContentSize
            titleLabel.frame.size.height = 44
        }
        self.title = nil
        self.navigationItem.titleView = titleLabel
    }
    
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}

extension UIImage {

    convenience init(color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let cgimg = img?.cgImage {
            self.init(cgImage: cgimg)
        } else {
            self.init()
        }
    }

    convenience init?(size: CGSize, gradientPoints: [GradientPoint], isHorizontal: Bool = true) {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)

        guard let context = UIGraphicsGetCurrentContext() else { return nil }       // If the size is zero, the context will be nil.
        guard let gradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: gradientPoints.compactMap { $0.color.cgColor.components }.flatMap { $0 }, locations: gradientPoints.map { CGFloat(truncating: $0.location) }, count: gradientPoints.count) else {
            return nil
        }

        var transformedStartPoint = CGPoint()
        var transformedEndPoint = CGPoint()

        if isHorizontal {
            transformedStartPoint = CGPoint.zero
            transformedEndPoint = CGPoint(x: size.width, y: 0)
        } else {
            transformedStartPoint = CGPoint.zero
            transformedEndPoint = CGPoint(x: 0, y: size.height)
        }

        context.drawLinearGradient(gradient, start: transformedStartPoint, end: transformedEndPoint, options: CGGradientDrawingOptions())
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        self.init(cgImage: image)
        defer { UIGraphicsEndImageContext() }
    }
}

extension UIImageView {
    func gradated(gradientPoints: [GradientPoint]) {
        let gradientMaskLayer       = CAGradientLayer()
        gradientMaskLayer.frame     = frame
        gradientMaskLayer.colors    = gradientPoints.map { $0.color.cgColor }
        gradientMaskLayer.locations = gradientPoints.map { $0.location as NSNumber }
        self.layer.insertSublayer(gradientMaskLayer, at: 0)
    }
}

extension UIImage {

    func scaleImage(toSize newSize: CGSize?, scale: CGFloat = 0) -> UIImage? {
        let newSize = newSize ?? self.size
        let rect: CGRect = CGRect(x: 0.0, y: 0.0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
        self.draw(in: rect)
        if let image = UIGraphicsGetImageFromCurrentImageContext(), let imageData = image.pngData() {
            return UIImage(data: imageData)
        }
        UIGraphicsEndImageContext()
        return nil

    }

    var circleMasked: UIImage? {
        let newImage = self.copy() as! UIImage
        let cornerRadius = self.size.height/2
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        let bounds = CGRect(origin: CGPoint.zero, size: self.size)
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).addClip()
        newImage.draw(in: bounds)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage

    }

    var squareImage: UIImage? {
        var imageHeight = self.size.height
        var imageWidth = self.size.width

        if imageHeight > imageWidth {
            imageHeight = imageWidth
        } else {
            imageWidth = imageHeight
        }

        let size = CGSize(width: imageWidth, height: imageHeight)

        let refWidth: CGFloat = CGFloat(self.cgImage!.width)
        let refHeight: CGFloat = CGFloat(self.cgImage!.height)

        let x = (refWidth - size.width) / 2
        let y = (refHeight - size.height) / 2

        let cropRect = CGRect(x: x, y: y, width: size.height, height: size.width)
        if let imageRef = self.cgImage!.cropping(to: cropRect) {
            return UIImage(cgImage: imageRef, scale: 0, orientation: self.imageOrientation)
        }

        return nil
    }

    /**
     Resize and make circular image to fit into annotation image
     */
    var createAnnoatationImage: UIImage {

        guard let sqaureImage = self.squareImage else {return #imageLiteral(resourceName: "icDriverRequestComingLocation")}
        guard let circleImage = sqaureImage.circleMasked else {return #imageLiteral(resourceName: "icDriverRequestComingLocation")}
        let imageSize = CGSize(width: 33, height: 50)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let pinImage = #imageLiteral(resourceName: "icDriverRequestComingLocation")
        pinImage.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: imageSize))
        let imageRect = CGRect(x: 4.5, y: 4, width: 23.7, height: 25)
        circleImage.draw(in: imageRect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result ?? pinImage
    }
}

extension Int {
func formatUsingAbbrevation () -> String {
    let numFormatter = NumberFormatter()

    typealias Abbrevation = (threshold: Double, divisor: Double, suffix: String)
    let abbreviations: [Abbrevation] = [(0, 1, ""),
                                       (1000.0, 1000.0, "K"),
                                       (100_000.0, 1_000_000.0, "M"),
                                       (100_000_000.0, 1_000_000_000.0, "B")]
                                       // you can add more !
    let startValue = Double(abs(self))
    let abbreviation: Abbrevation = {
        var prevAbbreviation = abbreviations[0]
        for tmpAbbreviation in abbreviations {
            if startValue < tmpAbbreviation.threshold {
                break
            }
            prevAbbreviation = tmpAbbreviation
        }
        return prevAbbreviation
    }()

    let value = Double(self) / abbreviation.divisor
    numFormatter.positiveSuffix = abbreviation.suffix
    numFormatter.negativeSuffix = abbreviation.suffix
    numFormatter.allowsFloats = true
    numFormatter.minimumIntegerDigits = 1
    numFormatter.minimumFractionDigits = 0
    numFormatter.maximumFractionDigits = 1

    return numFormatter.string(from: NSNumber(value: value))!
    }
}
