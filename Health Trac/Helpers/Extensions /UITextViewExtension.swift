//
//  UITextViewExtension.swift
//   Health Track
//

import UIKit

// MARK: - Methods
public extension UITextView {
    
    /// SwifterSwift: Scroll to the bottom of text view
    func scrollToBottom() {
        let range = NSRange(location: (text as NSString).length - 1, length: 1)
        scrollRangeToVisible(range)
    }
    
    /// SwifterSwift: Scroll to the top of text view
    func scrollToTop() {
        let range = NSRange(location: 0, length: 1)
        scrollRangeToVisible(range)
    }
    
    /// Check Empty Text View 
    func validate() -> Bool {
        
        guard let text =  self.text,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                return false
        }
        return true
    }
    
    /// Check limit of letters in textView
    func textLimit(newText: String, limit: Int) -> Bool {
        let text = self.text ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
    
    var cursorOffset: Int? {
        guard let range = selectedTextRange else { return nil }
        return offset(from: beginningOfDocument, to: range.start)
    }
    var cursorIndex: String.Index? {
        guard
            let location = cursorOffset,
            case let length = text.utf16.count-location
            else { return nil }
        return Range(.init(location: location, length: length), in: text)?.lowerBound
    }
    var cursorDistance: Int? {
        guard let cursorIndex = cursorIndex else { return nil }
        return text.distance(from: text.startIndex, to: cursorIndex)
    }
}
