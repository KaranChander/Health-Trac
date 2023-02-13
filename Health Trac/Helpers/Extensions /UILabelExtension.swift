//
//  UILabelExtension.swift
//   Health Track
//

import Foundation
import UIKit

// MARK: Label extension
class InsetLabel: UILabel {

    var setTopInset = CGFloat(0)
    var setBottomInset = CGFloat(0)
    var setLeftInset = CGFloat(0)
    var setRightInset = CGFloat(0)

    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: setTopInset, left: setLeftInset, bottom: setBottomInset, right: setRightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override public var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += setTopInset + setBottomInset
        intrinsicSuperViewContentSize.width += setLeftInset + setRightInset
        return intrinsicSuperViewContentSize
    }

    func edgeInsets(topInset: CGFloat, bottomInset: CGFloat, leftInset: CGFloat, rightInset: CGFloat) {

        setTopInset = topInset
        setBottomInset = bottomInset
        setLeftInset = leftInset
        setRightInset = rightInset
    }
}

extension UILabel {

    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }

    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }

    func AttributedFontColorForText(text: String, textColor: UIColor) {

        //self.textColor = UIColor.black
        guard let labelString = self.text else { return }

        let main_string = labelString as NSString
        let range = main_string.range(of: text)

        var  attribute = NSMutableAttributedString.init(string: main_string as String)
        if let labelAttributedString = self.attributedText {
            attribute = NSMutableAttributedString.init(attributedString: labelAttributedString)
        }
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)
        // attribute.addAttribute(NSBaselineOffsetAttributeName, value: 0, range: range)
        self.attributedText = attribute
    }

    func AttributedFontForText(text: String, textFont: UIFont) {

        //  self.textColor = UIColor.black
        guard let labelString = self.text else { return }

        let main_string = labelString as NSString
        let range = main_string.range(of: text)

        var  attribute = NSMutableAttributedString.init(string: main_string as String)
        if let labelAttributedString = self.attributedText {
            attribute = NSMutableAttributedString.init(attributedString: labelAttributedString)
        }

        attribute.addAttribute(NSAttributedString.Key.font, value: textFont, range: range)
        // attribute.addAttribute(NSBaselineOffsetAttributeName, value: 0, range: range)
        self.attributedText = attribute
    }

    func AttributedFontAndColorForText(atributedText: String, textFont: UIFont, textColor: UIColor) {

        guard let labelString = self.text else { return }

        let main_string = labelString as NSString
        //let range = main_string.range(of: atributedText)

        var  attribute = NSMutableAttributedString.init(string: main_string as String)
        if let labelAttributedString = self.attributedText {
            attribute = NSMutableAttributedString.init(attributedString: labelAttributedString)
        }

        if let regularExpression = try? NSRegularExpression(pattern: atributedText, options: .caseInsensitive) {
            let matchedResults = regularExpression.matches(in: labelString, options: [], range: NSRange(location: 0, length: labelString.count))
            for matched in matchedResults {
                attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: matched.range)

                attribute.addAttribute(NSAttributedString.Key.font, value: textFont, range: matched.range)

            }
        }

        // attribute.addAttribute(NSBaselineOffsetAttributeName, value: 0, range: range)
        self.attributedText = attribute
    }

    func AttributedFontColorForTextBackwards(text: String, textColor: UIColor) {

        guard let labelString = self.text else { return }

        let main_string = labelString as NSString
        let range = main_string.range(of: text, options: NSString.CompareOptions.backwards)

        var  attribute = NSMutableAttributedString.init(string: main_string as String)
        if let labelAttributedString = self.attributedText {
            attribute = NSMutableAttributedString.init(attributedString: labelAttributedString)
        }
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)

        self.attributedText = attribute

    }

    // for multiAttributed Text in single text
    func multiAttributedFontAndColorForText(atributedText: String, textFont: UIFont, textColor: UIColor) {

        guard let labelString = self.text else { return }

        let main_string = labelString as NSString
        let range = main_string.range(of: atributedText)

        var  attribute = NSMutableAttributedString.init(string: main_string as String)
        if let labelAttributedString = self.attributedText {
            attribute = NSMutableAttributedString.init(attributedString: labelAttributedString)
        }

        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)

        attribute.addAttribute(NSAttributedString.Key.font, value: textFont, range: range)

        // attribute.addAttribute(NSBaselineOffsetAttributeName, value: 0, range: range)
        self.attributedText = attribute
    }

    func AttributedBaseLineFontColorForText(text: String, textColor: UIColor) {

        //self.textColor = UIColor.black
        guard let labelString = self.text else { return }

        let main_string = labelString as NSString
        let range = main_string.range(of: text)

        var  attribute = NSMutableAttributedString.init(string: main_string as String)
        if let labelAttributedString = self.attributedText {
            attribute = NSMutableAttributedString.init(attributedString: labelAttributedString)
        }
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)
        attribute.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: range)
        attribute.addAttribute(NSAttributedString.Key.underlineColor, value: textColor, range: range)
        self.attributedText = attribute
    }

    func AttributedTextBackgroundColorForText(text: String, textColor: UIColor) {

        //self.textColor = UIColor.black
        guard let labelString = self.text else { return }

        let main_string = labelString as NSString
        let range = main_string.range(of: text)

        var  attribute = NSMutableAttributedString.init(string: main_string as String)
        if let labelAttributedString = self.attributedText {
            attribute = NSMutableAttributedString.init(attributedString: labelAttributedString)
        }
        attribute.addAttribute(NSAttributedString.Key.backgroundColor, value: textColor, range: range)
        // attribute.addAttribute(NSBaselineOffsetAttributeName, value: 0, range: range)
        self.attributedText = attribute
    }
    
    func AttributedBaseLineColorForText(text: String, lineColor: UIColor) {
        
        //self.textColor = UIColor.black
        guard let labelString = self.text else { return }
        
        let main_string = labelString as NSString
        let range = main_string.range(of: text)
        
        var  attribute = NSMutableAttributedString.init(string: main_string as String)
        if let labelAttributedString = self.attributedText {
            attribute = NSMutableAttributedString.init(attributedString: labelAttributedString)
        }
        attribute.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: range)
        attribute.addAttribute(NSAttributedString.Key.underlineColor, value: lineColor, range: range)
        self.attributedText = attribute
    }
    
    func addCharacterSpacing(of value: Double) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: value, range: NSRange(location: 0, length: attributedString.length-1))
            attributedText = attributedString
        }
    }
    
    ///Sets Up Time String with meridian at superscipt
    func setUpTimeString(text: String, baselineOffset: CGFloat, baseSize: CGFloat, superScript: CGFloat, font: AppFonts) {
        let data = Array(text)
        let baseString = String(data[0..<text.count-2])
        let meridianString = String(data[text.count-2..<text.count])
        let base = NSAttributedString(string: baseString,
                                            attributes: [
                                                .font: font.withSize(baseSize),
                                            ])
        printDebug("base = \(base)")
        let meridian = NSAttributedString(string: meridianString,
                                          attributes: [
                                            .baselineOffset: baselineOffset,
                                            .font: font.withSize(superScript),
                                          ])
        printDebug("meridian = \(meridian)")
        let attributedString = NSMutableAttributedString()
        attributedString.append(base)
        attributedString.append(meridian)
        self.attributedText = attributedString
    }

}

extension UILabel {
  func addCharacterSpacing(kernValue: Double = 1.15) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}
