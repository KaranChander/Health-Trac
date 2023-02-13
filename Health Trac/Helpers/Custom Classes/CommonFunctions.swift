//
//  CommonClasses.swift
// Health Track


import UIKit
import Toaster
import MobileCoreServices
import Contacts

class CommonFunctions {
    
    /// Show Toast With Message
    static func showToastWithMessage(_ msg: String, completion: (() -> Swift.Void)? = nil, success: Bool = false) {
        DispatchQueue.mainQueueAsync {
            ToastView.appearance().textColor = UIColor.init(light: AppColors.white, dark: AppColors.black)
            ToastView.appearance().backgroundColor = UIColor.init(light: AppColors.black, dark: AppColors.white)
            if msg.count > 60 {
                let toast = Toast(text: msg, delay: 0.3, duration: 5)
                toast.show()
            } else {
                let toast = Toast(text: msg, delay: 0.3, duration: 1.6)
                toast.show()
            }
        }
    }
    
    /// Delay Functions
    class func delay(delay: Double, closure:@escaping () -> Void) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when) {
            closure()
            
        }
    }
    
    /// Show Action Sheet With Actions Array
    class func showActionSheetWithActionArray(_ title: String?, message: String?,
                                              viewController: UIViewController,
                                              alertActionArray: [UIAlertAction],
                                              preferredStyle: UIAlertController.Style) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        alertActionArray.forEach { alert.addAction($0) }
        
        DispatchQueue.mainQueueAsync {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    /// Show Action Sheet With Actions Array
    class func showActivityViewController(_ content: [Any],
                                          viewController: UIViewController) {
        let activityViewController = UIActivityViewController(activityItems: content, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = viewController.view
        
        DispatchQueue.mainQueueAsync {
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    /// Show alert for settings
    final class func showPermissionAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringConstant.settings.value, style: .default) { _ in
            UIApplication.openSettingsApp
        })
        alert.addAction(UIAlertAction(title: StringConstant.cancel.value, style: .default, handler: nil))
        DispatchQueue.mainQueueAsync {
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }
    
    static func openUrl(url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    static func changehour(date: Date) -> Date? {
        var newDate = DateComponents()
        newDate.timeZone = TimeZone(identifier: "UTC")!
        var userCalendar = Calendar.init(identifier: .gregorian)
        userCalendar.timeZone = TimeZone(identifier: "UTC")!
        
        switch date.hour {
        case 0..<6:
            newDate.hour = 6

        case 6..<12:
            newDate.hour = 12

        case 12..<18:
            newDate.hour = 18

        case 18..<24:
        newDate.hour = 23
        
        default:
            newDate.hour = date.hour

        }
        newDate.minute = 0
        newDate.second = 0
        newDate.day = (userCalendar as NSCalendar).components(.day, from: date).day!
        newDate.month = (userCalendar as NSCalendar).components(.month, from: date).month!
        newDate.year = (userCalendar as NSCalendar).components(.year, from: date).year!
        newDate.timeZone = TimeZone(identifier: "UTC")!
        return userCalendar.date(from: newDate)
    }
    
    static func converTo12(hour: Int) -> Int {
        switch hour {
        case 0:
            return 12
        case 13:
            return 1
        case 14:
            return 2
        case 15:
            return 3
        case 16:
            return 4
        case 17:
            return 5
        case 18:
            return 6
        case 19:
            return 7
        case 20:
            return 8
        case 21:
            return 9
        case 22:
            return 10
        case 23:
            return 11
        case 24:
            return 0
        default:
            return hour
        }
    }
    
    static func convert12Hour(_ str : String) -> String
    {
        //  Get Hours
        var charArray: [String] = [String]()
        var newStr = Array(str)
        if newStr.count < 5 {
            newStr.insert("0", at: 0)
        }
        let h1 : Int = newStr[0].wholeNumberValue ?? 0
        let h2 : Int = newStr[1].wholeNumberValue ?? 1
        var hh : Int = h1 * 10 + h2;
        //  Finding out the Meridien of time
        //  ie. AM or PM
        var Meridien : String;
        if (hh < 12)
        {
            Meridien = "AM";
        }
        else
        {
            Meridien = "PM";
        }
        hh %= 12;
        //  Handle 00 and 12 case separately
        if (hh == 0)
        {
            let hour = "12"
            charArray.append(hour)
        }
        else
        {
            let hour = "\(hh)"
            charArray.append(hour)
        }
        let min = String(newStr[2..<str.count])
        charArray.append(min)
        charArray.append(Meridien)
        print(charArray)
        //  After time is printed
        //  cout Meridien
        let string = charArray.joined()
        print(string)
        return string
    }

    
    static func convertGlucoseUnit(value: Double, from: String) -> [GlucoseReading]{
        switch from {
        case GlucoseUnits.mmol.rawValue:
            return [GlucoseReading(reading: value*18.016, unit: GlucoseUnits.mgdl.rawValue)]
        case GlucoseUnits.mgdl.rawValue:
            return [GlucoseReading(reading: value/18.016, unit: GlucoseUnits.mmol.rawValue)]
        default:
            return [GlucoseReading()]
        }
        
    }
    
    ///Gets sets of dates having reading
    static func buildReadingDateSet(readings: [ReadingsDetail]) -> Set<String>{
        var dateSet: Set<String> = []
        for item in readings {
            dateSet.insert(item.createdDate.toCalendarString(dateFormat: "yyyy-MM-dd"))
        }
        return dateSet
    }
    
    static func correctReadingOrder(readings: [ReadingsDetail]) -> [ReadingsDetail] {
        var arr: [ReadingsDetail] = []
        if readings.count > 2 {
            var i = 0
            var j = 1
            var localArr: [ReadingsDetail] = []
            while j < readings.count {
                
                if readings[i].createdDate == readings[j].createdDate {
                    localArr.append(readings[i])
                    i+=1
                    j+=1
                } else {
                    localArr.append(readings[i])
                    arr.append(contentsOf: localArr.reversed())
                    localArr = []
                    i = j
                    j+=1
                }
            }
            if localArr.isEmpty {
                arr.append(readings[i])
            } else {
                localArr.append(readings[i])
                arr.append(contentsOf: localArr.reversed())
            }
        } else {
            arr = readings
        }
        return arr
    }
}
