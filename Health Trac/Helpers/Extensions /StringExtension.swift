//
//  StringExtention.swift
//   Health Track
//  

import Foundation
import UIKit
//import TTTAttributedLabel

extension String {
    
    ///Removes all spaces from the string
    var removeSpaces: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    ///Removes all HTML Tags from the string
    var removeHTMLTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    ///Returns a localized string
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    ///Removes leading and trailing white spaces from the string
    var byRemovingLeadingTrailingWhiteSpaces: String {
        
        let spaceSet = CharacterSet.whitespaces
        return self.trimmingCharacters(in: spaceSet)
    }
    
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    public func trimTrailingWhitespace() -> String {
        if let trailingWs = self.range(of: "\\s+$", options: .regularExpression) {
            return self.replacingCharacters(in: trailingWs, with: "")
        } else {
            return self
        }
    }
    ///Returns 'true' if the string is any (file, directory or remote etc) url otherwise returns 'false'
    var isAnyUrl: Bool {
        return (URL(string: self) != nil)
    }
    
    var isNumberString: Bool {
        let spaceSet = CharacterSet.decimalDigits.inverted
        return (self.rangeOfCharacter(from: spaceSet) == nil)
    }
    
    ///Returns the json object if the string can be converted into it, otherwise returns 'nil'
    var jsonObject: Any? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        return nil
    }
    
    ///Returns the base64Encoded string
    var base64Encoded: String {
        
        return Data(self.utf8).base64EncodedString()
    }
    
    ///Returns the string decoded from base64Encoded string
    var base64Decoded: String? {
        
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func heightOfText(_ width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func widthOfText(_ height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
    
    func localizedString(lang: String) -> String {
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        printDebug(path)
        let bundle = Bundle(path: path!)
        printDebug(bundle)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    ///Returns 'true' if string contains the substring, otherwise returns 'false'
    func contains(s: String) -> Bool {
        return self.range(of: s) != nil ? true: false
    }
    
    ///Replaces occurances of a string with the given another string
    func replace(string: String, withString: String) -> String {
        return self.replacingOccurrences(of: string, with: withString, options: String.CompareOptions.literal, range: nil)
    }
    
    ///Converts the string into 'Date' if possible, based on the given date format and timezone. otherwise returns nil
    func toDate(dateFormat: String, timeZone: TimeZone = TimeZone.current) -> Date? {
        
        let frmtr = DateFormatter()
//        frmtr.locale = Locale(identifier: "en_US_POSIX")
        frmtr.timeZone = .current
        frmtr.dateFormat = dateFormat
        //        frmtr.timeZone = timeZone
//        return frmtr.date(from: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
//        {
//            return dateFromString
//            print(dateFromString)   // "2015-08-19 09:00:00 +0000"
//            dateFormatter.timeZone = .current
//            dateFormatter.dateFormat = dateFormat
//            dateFormatter.string(from: dateFromString)  // 19-08-2015 06:00 AM -0300"
//        }
//        return dateFormatter.date(from: self)
    }
    
    ///Converts the string into 'Date' if possible, based on the given date format and timezone. otherwise returns nil
    func toLegsilationStateDate(dateFormat: String, timeZone: TimeZone = TimeZone.current) -> Date? {
        
        let frmtr = DateFormatter()
        frmtr.locale = Locale(identifier: "en_US_POSIX")
        frmtr.dateFormat = dateFormat
//        frmtr.timeZone = timeZone
        return frmtr.date(from: self)
    }
    
    func toBirthDate(dateFormat: String, timeZone: TimeZone = TimeZone.current) -> Date? {
        
        let frmtr = DateFormatter()
        //            frmtr.locale = Locale(identifier: "en_US_POSIX")
        frmtr.dateFormat = dateFormat
        frmtr.timeZone = NSTimeZone(name: "UTC") as TimeZone? ?? .current
        return frmtr.date(from: self)
    }
    
    func toElectionDate(dateFormat: String, timeZone: TimeZone = TimeZone.current) -> Date? {
        
        let frmtr = DateFormatter()
        frmtr.locale = Locale(identifier: "en_US_POSIX")
        frmtr.dateFormat = dateFormat
        frmtr.timeZone = timeZone
        return frmtr.date(from: self)
    }
    
    func toDateText(inputDateFormat: String, outputDateFormat: String, timeZone: TimeZone = TimeZone.current) -> String {
        
        if let date = self.toDate(dateFormat: inputDateFormat, timeZone: timeZone) {
            return date.toString(dateFormat: outputDateFormat, timeZone: timeZone)
        } else {
            return ""
        }
    }
    
    func checkIfValid(_ validityExression: ValidityExression) -> Bool {
        
        let regEx = validityExression.rawValue
        
        let test = NSPredicate(format: "SELF MATCHES %@", regEx)
        
        return test.evaluate(with: self)
    }
    
    func checkIfInvalid(_ validityExression: ValidityExression) -> Bool {
        
        return !self.checkIfValid(validityExression)
    }
    
    ///Capitalize the very first letter of the sentence.
    var capitalizedFirst: String {
        guard !isEmpty else { return self }
        var result = self
        let substr1 = String(self[startIndex]).uppercased()
        result.replaceSubrange(...startIndex, with: substr1)
        return result
    }
    
    func camelCaseToWords() -> String {
        return unicodeScalars.reduce("") {
            if CharacterSet.uppercaseLetters.contains($1) {
                return ($0 + " " + String($1))
            }
            else {
                return $0 + String($1)
            }
        }
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    
    func getLastNSubString(number: Int) -> String {
        return String(self.suffix(number))
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
    
    public var isAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    
    public func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
    
    public func starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }
}

extension String {
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? self.removeHTMLTags
    }
}

extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int {
        string.distance(from: string.startIndex, to: self)
    }
}

enum ValidityExression: String {
    
    case userName = "^[a-zA-z]{1,}+[a-zA-z0-9!@#$%&*]{2,15}"
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case mobileNumber = "^[0-9]{7,14}$"
    case password = "(?=[^A-Z]*[A-Z])(?=[^a-z]*[a-z])(?=[^0-9]*[0-9]).{8,50}"
    //    case password = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,50}$"
    case name = "^[a-zA-Z]{2,15}"
    case webUrl = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
    case interest = "/  +/g"
}

extension String {
    func indices(of occurrence: String) -> [Int] {
        var indices = [Int]()
        var position = startIndex
        while let range = range(of: occurrence, range: position..<endIndex) {
            let i = distance(from: startIndex,
                             to: range.lowerBound)
            indices.append(i)
            let offset = occurrence.distance(from: occurrence.startIndex,
                                             to: occurrence.endIndex) - 1
            guard let after = index(range.lowerBound,
                                    offsetBy: offset,
                                    limitedBy: endIndex) else {
                break
            }
            position = index(after: after)
        }
        return indices
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    
    func getAvailableUrls() -> [NSTextCheckingResult] {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
            return matches
        } catch {
            printDebug("Link error in label")
        }
        return []
    }
    
    
    /// Create `Data` from hexadecimal string representation
    ///
    /// This creates a `Data` object from hex string. Note, if the string has any spaces or non-hex characters (e.g. starts with '<' and with a '>'), those are ignored and only hex characters are processed.
    ///
    /// - returns: Data represented by this hexadecimal string.
    
    var hexadecimal: Data? {
        var data = Data(capacity: count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }
        
        guard data.count > 0 else { return nil }
        
        return data
    }

}

extension String {
    func addTime(hours: Int, min: Int, isMeridiemNeeded: Bool) -> String {
        let subDate = self.split(separator: "-")
        let newTime = subDate[subDate.count-1].replacingOccurrences(of: ":", with: " ")
        printDebug(newTime)
        let subTime = newTime.split(separator: " ")
        printDebug(subTime)
        let timeHours = Int(subTime[0])
        let timeMins = Int(subTime[1])
        var timeMeridiem: String = ""
        if subTime.count == 3 {
            timeMeridiem = String(subTime[2])
        }
        
        guard var timeHours = timeHours, var timeMins = timeMins else { return "" }
        timeHours += hours
        timeMins += min
        if timeMins >= 60 {
            timeHours += 1
            timeMins -= 60
        }
        if timeHours >= 12 {
            if timeHours > 12 {
                timeHours -= 12
            }
            if timeMeridiem == "AM" {
                timeMeridiem = "PM"
            } else if timeMeridiem == "PM" {
                timeMeridiem = "AM"
            }
            if timeMeridiem == "" {
                if timeHours > 12 {
                    timeHours -= 12
                    timeMeridiem = "AM"
                } else {
                    timeMeridiem = "PM"
                }
                
            }
        }
        var timeMinString = String(timeMins)
        if timeMins < 10 {
            timeMinString = "0\(String(timeMins))"
        }
        if isMeridiemNeeded {
            return "\(timeHours):\(timeMinString) \(timeMeridiem)"
        } else {
            return "\(timeHours):\(timeMinString)"
        }
        
    }
}
