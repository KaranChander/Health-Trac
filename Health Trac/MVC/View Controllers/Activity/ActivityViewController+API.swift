//
//  ActivityViewController+API.swift
//   Health Track


import Foundation
import UIKit

extension ActivityViewController {
    
    ///Gets reading data at a particular date
    func getReadingsData(date: Date = Date().localDate()) {
        let readingsDBArray = ReadingsDetail.getDirectReadingList()
         printDebug(readingsDBArray)
        let readingArray: [ReadingsDetail] = readingsDBArray ?? []
        self.dateSet = CommonFunctions.buildReadingDateSet(readings: readingArray)
        var filteredDates = readingArray.filter { item in
            return item.createdDate.day == date.day && item.createdDate.month == date.month
        }
        filteredDates = filteredDates.sorted(by: { reading1, reading2 in
            return reading1.createdDate > reading2.createdDate
        })
        filteredDates = CommonFunctions.correctReadingOrder(readings: filteredDates)
        let sections = filteredDates
            .map { item in
                return item.createdDate.startOfHour()
        }.reduce([]) { dates, date in
            return dates.last == date ? dates : dates + [date]
        }.compactMap { startDate -> (date: Date, items: [ReadingsDetail]) in
            let endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate!)!
            let items = filteredDates.filter {$0.createdDate >= startDate! &&  $0.createdDate < endDate }
            return items.isEmpty ? (date: Date(), items: items) : (date: CommonFunctions.changehour(date: startDate!)!, items: items)
        }
        var newSection: [(date: Date, items: [ReadingsDetail])] = []
        var array: [ReadingsDetail] = []
        var date: Date? = nil
        for section in sections {
            if section.date != date {
                newSection.append(section)
            } else {
                for item in section.items {
                    array.append(item)
                }
                newSection[newSection.endIndex - 1].items.append(contentsOf: array)
                array.removeAll()
            }
            date = section.date
        }
        self.sections = newSection
        if self.sections.isEmpty {
            self.settingEmptyDataSet(placeholder: StringConstant.noActivityDateFound.value, placeholderTV: self.activityView.activityTableView)
        }
        self.activityView.activityTableView.reloadData()
        self.activityView.activityTableView.beginUpdates()
        self.activityView.activityTableView.setContentOffset(.zero, animated: true)
        self.activityView.activityTableView.endUpdates()
    }
}

