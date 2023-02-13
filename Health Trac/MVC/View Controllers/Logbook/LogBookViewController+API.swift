//
//  LogBookViewController+API.swift
//   Health Track


import Foundation

extension LogbookViewController {
    
    ///Gets reading data at a particular date
    func getReadingsData(date: Date = Date().localDate()){
        let readingsDBArray = ReadingsDetail.getDirectReadingList() ?? []
        printDebug(readingsDBArray)
        var readings: [GlucoseReading] = []
        self.dateSet = CommonFunctions.buildReadingDateSet(readings: readingsDBArray)
        var filteredDates: [ReadingsDetail] = []
        filteredDates = (readingsDBArray).filter { item in
            return item.createdDate.day == date.day && date.month == Date().month
        }
        filteredDates = CommonFunctions.correctReadingOrder(readings: filteredDates)
        
        //For Glucose
        let glucoseReading = (filteredDates).filter { item in
            return item.readingType == ReadingsType.glucose.rawValue
        }
        if glucoseReading.count != 0 {
            logbookView.hideContainerView(container: logbookView.glucoseContainerView, status: false)
            self.latestGlucoseReadings = glucoseReading
        } else {
            logbookView.hideContainerView(container: logbookView.glucoseContainerView, status: true)
        }
        
        //For Exercise
        let exerciseReading = (filteredDates).filter { item in
            return item.readingType == ReadingsType.exercise.rawValue
        }
        if exerciseReading.count != 0 {
            logbookView.hideContainerView(container: logbookView.exerciseContainerView, status: false)
            self.latestExerciseReadings = exerciseReading
        } else {
            logbookView.hideContainerView(container: logbookView.exerciseContainerView, status: true)
        }
        
        //For Carbs
        let carbsReading = (filteredDates).filter { item in
            return item.readingType == ReadingsType.carbs.rawValue
        }
        if carbsReading.count != 0 {
            logbookView.hideContainerView(container: logbookView.carbsContainerView, status: false)
            self.latestCarbsReadings = carbsReading
        } else {
            logbookView.hideContainerView(container: logbookView.carbsContainerView, status: true)
        }
    }
}
