import Foundation

extension Date {

    // MARK: - DATE FORMAT ENUM
    //==========================
    enum DateFormat: String {

        case yyyy_MM_dd = "yyyy-MM-dd"
        case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
        case yyyyMMddTHHmmssz = "yyyy-MM-dd'T'HH:mm:ssZ"
        case yyyyMMddHHmmssz = "yyyy-MM-ddHH:mm:ssZ"
        case yyyyMMddHHmmsszK = "yyyy-MM-dd HH:mm:ss Z"
        case yyyyMMddTHHmmssssZZZZZ = "yyyy-MM-dd'T'HH:mm:ss.ssZZZZZ"
        case yyyyMMdd = "yyyy/MM/dd"
        case ddMMyy = "dd/MM/yy"
        case MMddyy = "MM/dd/yy"
        case dMMMyyyy = "d MMM, yyyy"
        case MMMdyyyy = "MMM d, yyyy"
        case ddMMMyyyy = "dd MMM yyyy"
        case hmmazzz = "h:mm a"
        case hmm = "h:mm"
        case MMMdyyyyHHmmss = "MMM d, yyyy HH:mm:ss"
        case dMMMEEEHHmmss = "d MMM, EEEE h:mm a"
        case MMMdyyyyHHmma = "MMM d yyyy, h:mm a"
        case yyyyMMddTHHmmsssz = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        case yyyyMMddTHHmmssssz = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case MMMdyyyyHHmmssa = "MMM d, yyyy - h:mm a"

        case dd = "dd"
        case mm = "MM"
        case yyyy = "YYYY"

        case EEEE = "EEEE"
        case EEE = "EEE"
        case MMM = "MMM"
        case yy = "yy"
    }

    static let todaysDate = Date()
    static let dateFormatter = DateFormatter()
    static let userCalendar = Calendar.init(identifier: .gregorian)
    var calendar: Calendar {
        var calendar = Date.userCalendar
        calendar.timeZone = TimeZone(identifier: "UTC") ?? .current

        return calendar
    }
    var isToday: Bool {
        return calendar.isDateInToday(self)
    }
    var isYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }
    var isTomorrow: Bool {
        return calendar.isDateInTomorrow(self)
    }
    var isWeekend: Bool {
        return calendar.isDateInWeekend(self)
    }
    var year: Int {
        return (calendar as NSCalendar).components(.year, from: self).year!
    }
    var month: Int {
        return (calendar as NSCalendar).components(.month, from: self).month!
    }
    var weekOfYear: Int {
        return (calendar as NSCalendar).components(.weekOfYear, from: self).weekOfYear!
    }
    var weekday: Int {
        return (calendar as NSCalendar).components(.weekday, from: self).weekday!
    }
    var weekdayOrdinal: Int {
        return (calendar as NSCalendar).components(.weekdayOrdinal, from: self).weekdayOrdinal!
    }
    var weekOfMonth: Int {
        return (calendar as NSCalendar).components(.weekOfMonth, from: self).weekOfMonth!
    }
    var day: Int {
        return (calendar as NSCalendar).components(.day, from: self).day!
    }
    var hour: Int {
        return (calendar as NSCalendar).components(.hour, from: self).hour!
    }
    var minute: Int {
        return (calendar as NSCalendar).components(.minute, from: self).minute!
    }
    var second: Int {
        return (calendar as NSCalendar).components(.second, from: self).second!
    }
    var numberOfWeeks: Int {
        let weekRange = (calendar as NSCalendar).range(of: .weekOfYear, in: .month, for: Date())
        return weekRange.length
    }
    var unixTimestamp: Double {

        return self.timeIntervalSince1970
    }

    func yearsFrom(_ date: Date) -> Int {
        return (calendar as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }
    func monthsFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }
    func weeksFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    func weekdayFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.weekday, from: date, to: self, options: []).weekday!
    }
    func weekdayOrdinalFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.weekdayOrdinal, from: date, to: self, options: []).weekdayOrdinal!
    }
    func weekOfMonthFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.weekOfMonth, from: date, to: self, options: []).weekOfMonth!
    }
    func daysFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
    func hoursFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }
    func minutesFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
    func secondsFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    func offsetFrom(_ date: Date) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }

    ///Converts a given Date into String based on the date format and timezone provided
    func toString(dateFormat: String, timeZone: TimeZone = TimeZone.current) -> String {

        let frmtr = DateFormatter()
        frmtr.dateFormat = dateFormat
        frmtr.timeZone = timeZone
        return frmtr.string(from: self)
    }
    
    ///Converts a given Date into String based on the date format and timezone provided
    func toCalendarString(dateFormat: String, timeZone: TimeZone = TimeZone.current) -> String {

        let frmtr = DateFormatter()
        frmtr.dateFormat = dateFormat
        frmtr.timeZone = NSTimeZone(name: "UTC") as TimeZone? ?? .current
        return frmtr.string(from: self)
    }
    
    ///Converts a given Date into String based on the date format and timezone provided
    func toBirthString(dateFormat: String, timeZone: TimeZone = TimeZone.current) -> String {

        let frmtr = DateFormatter()
        frmtr.dateFormat = dateFormat
        frmtr.timeZone = NSTimeZone(name: "UTC") as TimeZone? ?? .current
        return frmtr.string(from: self)
    }
    
    func calculateAge() -> Int {

        let calendar: Calendar = Calendar.current
        let unitFlags: NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day]
        let dateComponentNow: DateComponents = (calendar as NSCalendar).components(unitFlags, from: Date())
        let dateComponentBirth: DateComponents = (calendar as NSCalendar).components(unitFlags, from: self)

        if (dateComponentNow.month! < dateComponentBirth.month!) ||
            ((dateComponentNow.month! == dateComponentBirth.month!) && (dateComponentNow.day! < dateComponentBirth.day!)) {
            return dateComponentNow.year! - dateComponentBirth.year! - 1
        } else {
            return dateComponentNow.year! - dateComponentBirth.year!
        }
    }

    static func zero() -> Date {
        let dateComp = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, era: 0, year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0, nanosecond: 0, weekday: 0, weekdayOrdinal: 0, quarter: 0, weekOfMonth: 0, weekOfYear: 0, yearForWeekOfYear: 0)
        return dateComp.date!
    }

    func convertToString() -> String {
        // First, get a Date from the String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMddHHmmss.rawValue
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        let local = dateFormatter.string(from: self)
        return local
    }
    
    
    func convertToFormattedString() -> String {
        // First, get a Date from the String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.MMMdyyyy.rawValue
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        // Now, get a new string from the Date in the proper format for the user's locale
//        dateFormatter.dateFormat = nil
//        dateFormatter.dateStyle = .long // set as desired
//        dateFormatter.timeStyle = .medium // set as desired
        let local = dateFormatter.string(from: self)
        return local
    }
    
    func convertToStringForCalendar() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMddHHmmss.rawValue
        dateFormatter.timeZone = TimeZone.current
        let local = dateFormatter.string(from: self)
        return local
    }

    var timeAgoSince: String {

        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: self, to: now, options: [])

        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        }

        if let year = components.year, year >= 1 {
            return "Last year"
        }

        if let month = components.month, month >= 2 {
            return "\(month) months ago"
        }

        if let month = components.month, month >= 1 {
            return "Last month"
        }

        if let week = components.weekOfYear, week >= 2 {
            return "\(week) weeks ago"
        }

        if let week = components.weekOfYear, week >= 1 {
            return "Last week"
        }

        if let day = components.day, day >= 2 {
            return "\(day) days ago"
        }

        if let day = components.day, day >= 1 {
            return "Yesterday"
        }

        if let hour = components.hour, hour >= 2 {
            return "Today"
        }

        if let hour = components.hour, hour >= 1 {
            return "Today"
        }

        if let minute = components.minute, minute >= 2 {
            return "Today"
        }

        if let minute = components.minute, minute >= 1 {
            return "Today"
        }

        if let second = components.second, second >= 3 {
            return "Today"
        }

        return "Today"
    }
}


public extension Date {

    func plus(seconds s: UInt) -> Date {
        return self.addComponentsToDate(seconds: Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }

    func minus(seconds s: UInt) -> Date {
        return self.addComponentsToDate(seconds: -Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }

    func plus(minutes m: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }

    func minus(minutes m: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: -Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }

    func plus(hours h: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }

    func minus(hours h: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: -Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }

    func plus(days d: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: Int(d), weeks: 0, months: 0, years: 0)
    }

    func minus(days d: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: -Int(d), weeks: 0, months: 0, years: 0)
    }

    func plus(weeks w: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: Int(w), months: 0, years: 0)
    }

    func minus(weeks w: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: -Int(w), months: 0, years: 0)
    }

    func plus(months m: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: Int(m), years: 0)
    }

    func minus(months m: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: -Int(m), years: 0)
    }

    func plus(years y: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: Int(y))
    }

    func minus(years y: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -Int(y))
    }

    fileprivate func addComponentsToDate(seconds sec: Int, minutes min: Int, hours hrs: Int, days d: Int, weeks wks: Int, months mts: Int, years yrs: Int) -> Date {
        var dc = DateComponents()
        dc.second = sec
        dc.minute = min
        dc.hour = hrs
        dc.day = d
        dc.weekOfYear = wks
        dc.month = mts
        dc.year = yrs
        return Calendar.current.date(byAdding: dc, to: self)!
    }

    func midnightUTCDate() -> Date {
        var dc: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        dc.hour = 0
        dc.minute = 0
        dc.second = 0
        dc.nanosecond = 0
        dc.timeZone = TimeZone(secondsFromGMT: 0)
        return Calendar.current.date(from: dc)!
    }

    static func secondsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.second], from: d1, to: d2)
        return dc.second!
    }

    static func minutesBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.minute], from: d1, to: d2)
        return dc.minute!
    }

    static func hoursBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.hour], from: d1, to: d2)
        return dc.hour!
    }

    static func daysBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.day], from: d1, to: d2)
        return dc.day!
    }

    static func weeksBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.weekOfYear], from: d1, to: d2)
        return dc.weekOfYear!
    }

    static func monthsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.month], from: d1, to: d2)
        return dc.month!
    }

    static func yearsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = Calendar.current.dateComponents([.year], from: d1, to: d2)
        return dc.year!
    }

    // MARK: Comparison Methods

    func isGreaterThan(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedDescending)
    }

    func isLessThan(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedAscending)
    }

    func yearOfDate() -> String? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
        // or use capitalized(with: locale) if you want

    }

    func monthOfDate() -> String {
        let monthValue = Calendar.current.component(.month, from: self)
        return monthValue > 9 ? "\(monthValue)": "0\(monthValue)"
    }
    
    var millisecondsSince1970: Double {
        return (self.timeIntervalSince1970 * 1000.0).rounded()
    }
    
    func startOfHour() -> Date? {
        var newDate = DateComponents()
        newDate.timeZone = TimeZone(identifier: "UTC")
        var userCalendar = Calendar.init(identifier: .gregorian)
        userCalendar.timeZone = TimeZone(identifier: "UTC")!

        newDate.hour = self.hour
        newDate.minute = 0
        newDate.second = 0
        newDate.day = (userCalendar as NSCalendar).components(.day, from: self).day!
        newDate.month = (userCalendar as NSCalendar).components(.month, from: self).month!
        newDate.year = (userCalendar as NSCalendar).components(.year, from: self).year!
        newDate.timeZone = TimeZone(identifier: "UTC")!
        return userCalendar.date(from: newDate)
    }
    
    func localDate() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) else {return Date()}

        return localDate
    }
    
    func currentLocalDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = TimeZone.current.secondsFromGMT()
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

        return localDate
    }
    
}
