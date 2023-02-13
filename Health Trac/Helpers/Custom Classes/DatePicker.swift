//
//  DatePickerView.swift
//   Health Track


import UIKit
import SwiftUI

class DatePickerView : UIPickerView {
    
    // MARK: - Variables
    //========================================================
    var selectedLabelColor: UIColor = .white
    var unselectedLabelColor: UIColor =  UIColor(light: AppColors.black, dark: AppColors.white)
    var todaysRow: Int = 365
    
    // MARK: - Functions
    //========================================================
    
    ///Returns index of selected date
    func selectedDate()->Int{
        AppConstants.dateCollection = buildDateCollection()
        var row = 0
        for index in AppConstants.dateCollection.indices{
            let today = Date().localDate()
            if Calendar.current.compare(today, to: AppConstants.dateCollection[index], toGranularity: .day) == .orderedSame{
                row = index
            }
        }
        return row
    }
    
    ///Returns index of selected hour of the day
    func selectedHour() -> Int {
        var row = 0
        for index in 0..<AppConstants.hours.count{
            let timeArray = formatTimePicker(date: Date())
            printDebug(timeArray[0])
            if timeArray[0] == AppConstants.hours[index] {
                row = index
            }
        }
        return row
    }
    
    ///Returns index of selected minute
    func selectedMin() -> Int {
        var row = 0
        for index in 0..<AppConstants.mins.count{
            let timeArray = formatTimePicker(date: Date())
            if timeArray[1] == AppConstants.mins[index] {
                row = index
            }
        }
        return row
    }
    
    ///Returns index of selected meridiem
    func selectedMeridiem() -> Int {
        var row = 0
        for index in 0..<AppConstants.meridiem.count{
            let timeArray = formatTimePicker(date: Date())
            if timeArray[2] == AppConstants.meridiem[index] {
                row = index
            }
        }
        return row
    }
    
    ///Builds date collection
    func buildDateCollection()-> [Date]{
        AppConstants.dateCollection.append(contentsOf: Date.previousYear())
        AppConstants.dateCollection.append(contentsOf: Date.nextYear())
        return AppConstants.dateCollection
    }
}

// MARK: - UIPickerViewDelegate
//========================================================
extension DatePickerView : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let date = formatDate(date: AppConstants.dateCollection[selectedRow(inComponent: 0)])
        pickerView.reloadAllComponents()
        NotificationCenter.default.post(name: .dateChanged, object: nil, userInfo:["date":date])
        
        printDebug("\(date), \(AppConstants.hours[selectedRow(inComponent: 1)]):\(AppConstants.mins[selectedRow(inComponent: 3)]) \(AppConstants.meridiem[selectedRow(inComponent: 4)])")
        if selectedRow(inComponent: 0) >= todaysRow {
            pickerView.selectRow(todaysRow, inComponent: 0, animated: true)
        }
        if selectedRow(inComponent: 0) == todaysRow {
            if selectedRow(inComponent: 4) >= selectedMeridiem() {
                pickerView.selectRow(selectedMeridiem(), inComponent: 4, animated: true)
                if selectedHour() == 11 {
                    if selectedRow(inComponent: 1) < 11 {
                        pickerView.selectRow(11, inComponent: 1, animated: true)
                    }
                    if selectedRow(inComponent: 3) > selectedMin() {
                        pickerView.selectRow(selectedMin(), inComponent: 3, animated: true)
                    }
                }
                if selectedRow(inComponent: 1) >= selectedHour() && selectedRow(inComponent: 1) != 11 {
                    pickerView.selectRow(selectedHour(), inComponent: 1, animated: true)
                    if selectedRow(inComponent: 3) > selectedMin() {
                        pickerView.selectRow(selectedMin(), inComponent: 3, animated: true)
                    }
                }
            }
        }
    }
    
    func formatDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
}

// MARK: - UIPickerViewDataSource
//========================================================
extension DatePickerView : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return AppConstants.dateCollection.count
        case 1:
            return AppConstants.hours.count
        case 2:
            return 1
        case 3:
            return AppConstants.mins.count
        case 4:
            return AppConstants.meridiem.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel?
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
        }
        
        var color: UIColor = .white
        if pickerView.selectedRow(inComponent: component) == row {
            color = selectedLabelColor
        } else {
            color = UIColor(light: AppColors.black, dark: AppColors.white)
        }
        var titleData: String = ""
        var attributes: [NSAttributedString.Key: Any] = [:]
        switch component {
        case 0:
            titleData = formatDatePicker(date: AppConstants.dateCollection[row])
            if titleData == formatDatePicker(date: Date()) {
                self.todaysRow = row
                printDebug(todaysRow)
                titleData = "Today"
            }
            pickerLabel?.textAlignment = .right
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(18), NSAttributedString.Key.kern: 2]
            
        case 1:
            titleData = "\(String(AppConstants.hours[row]))"
            pickerLabel?.textAlignment = .right
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(18)]
        case 3:
            titleData = "\(String(AppConstants.mins[row]))"
            pickerLabel?.textAlignment = .center
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(18), NSAttributedString.Key.kern: 2]
        case 4:
            titleData = AppConstants.meridiem[row]
            pickerLabel?.textAlignment = .right
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(18), NSAttributedString.Key.kern: 2]
        default:
            titleData = ""
        }
        let myTitle = NSAttributedString(string: titleData, attributes: attributes)
        pickerLabel!.attributedText = myTitle
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        52
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0:
            return 140
        case 1:
            return 48
        case 2:
            return 30
        case 3:
            return 36
        case 4:
            return 42
        default:
            return 0
        }
    }
    
    func formatDatePicker(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d"
        return dateFormatter.string(from: date)
    }
    
    func formatTimePicker(date: Date) -> [String]{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H mm"
        let timeSTring = dateFormatter.string(from: date)
        var timeArray = timeSTring.components(separatedBy: " ")
        if timeArray.count == 2 {
            if (Int(timeArray[0]) ?? 1) > 11 {
                var hour = ((Int(timeArray[0]) ?? 1) - 12)
                if hour == 0 {
                    hour = 12
                }
                timeArray[0] = "\(hour)"
                timeArray.append(AppConstants.meridiem[1])
            } else {
                if (Int(timeArray[0]) ?? 1) == 0 {
                    let hour = ((Int(timeArray[0]) ?? 1) + 12)
                    timeArray[0] = "\(hour)"
                }
                timeArray.append(AppConstants.meridiem[0])
            }
        }
        return timeArray
    }
}

// MARK - Observer Notification Init
extension Notification.Name{
    static var dateChanged : Notification.Name{
        return .init("dateChanged")
    }
    
}

// MARK - Date extension
extension Date {
    static func nextYear() -> [Date]{
        return Date.next(numberOfDays: 365, from: Date())
    }
    
    static func previousYear()-> [Date]{
        return Date.next(numberOfDays: 365, from: Calendar.current.date(byAdding: .year, value: -1, to: Date())!)
    }
    
    static func next(numberOfDays: Int, from startDate: Date) -> [Date]{
        var dates = [Date]()
        for i in 0..<numberOfDays {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: startDate) {
                dates.append(date)
            }
        }
        return dates
    }
}

class Util{
    func formatDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd yyyy"
        return dateFormatter.string(from: date)
    }
}

