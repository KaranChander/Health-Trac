//
//  HomeViewController+API.swift
//  Health Track


import Foundation

// HomeViewController + API
extension HomeViewController {
    
    ///Gets reading data at a particular date
    func getReadingsData(date: Date = Date().localDate()) {
        guard let readingData = ReadingsDetail.getSeparateReading() else {return}
        let allReadings: [ReadingsDetail] = Array([readingData.glucose, readingData.exercise, readingData.carbs].joined())
        self.dateSet = CommonFunctions.buildReadingDateSet(readings: allReadings)
        var filteredDates = readingData.glucose.filter { item in
            return item.createdDate.day == date.day
            && item.createdDate.month == date.month
            && item.createdDate.year == date.year
        }.sorted { ReadingOne, ReadingTwo in
            return ReadingOne.createdDate > ReadingTwo.createdDate
        }
        filteredDates = CommonFunctions.correctReadingOrder(readings: filteredDates)
        var readings: [GlucoseReading] = []
        if filteredDates.count > 0 {
            let firstReading = filteredDates[0]
            self.homeView.pageControl.numberOfPages = 2
            self.readingLevel = filteredDates[0].readingLevel
            self.glucoseReadingType = filteredDates[0].glucoseReadingType
            var reading = GlucoseReading()
            if filteredDates[0].glucoseReadingType == glucoseReadingsType.blood.rawValue {
                switch filteredDates[0].glucoseUnit {
                case GlucoseUnits.mmol.rawValue:
                    reading.glucoseUnit = filteredDates[0].glucoseUnit
                    reading.glucoseReading = filteredDates[0].glucoseReading
                    readings.append(reading)
                    
                    readings.append(contentsOf: CommonFunctions.convertGlucoseUnit(value: filteredDates[0].glucoseReading, from: GlucoseUnits.mmol.rawValue))
                    
                    readings.append(contentsOf: [GlucoseReading(reading: filteredDates[0].glucoseReading/10, unit: GlucoseUnits.mmol.rawValue)])
                    
                    readings.append(contentsOf: CommonFunctions.convertGlucoseUnit(value: filteredDates[0].glucoseReading/10, from: GlucoseUnits.mmol.rawValue))
                case GlucoseUnits.mgdl.rawValue:
                    readings.append(contentsOf: CommonFunctions.convertGlucoseUnit(value: filteredDates[0].glucoseReading, from: GlucoseUnits.mgdl.rawValue))
                    reading.glucoseUnit = filteredDates[0].glucoseUnit
                    reading.glucoseReading = filteredDates[0].glucoseReading
                    readings.append(reading)
                    readings.append(contentsOf: CommonFunctions.convertGlucoseUnit(value: filteredDates[0].glucoseReading/10, from: GlucoseUnits.mgdl.rawValue))
                    readings.append(contentsOf: [GlucoseReading(reading: filteredDates[0].glucoseReading/10, unit: GlucoseUnits.mgdl.rawValue)])
                default:
                    break
                }
            } else {
                switch filteredDates[0].glucoseUnit {
                case GlucoseUnits.mmol.rawValue:
                    reading.glucoseUnit = filteredDates[0].glucoseUnit
                    reading.glucoseReading = (filteredDates[0].glucoseReading)*10
                    readings.append(reading)
                    readings.append(contentsOf: CommonFunctions.convertGlucoseUnit(value: filteredDates[0].glucoseReading*10, from: GlucoseUnits.mmol.rawValue))
                    readings.append(contentsOf: [GlucoseReading(reading: filteredDates[0].glucoseReading, unit: GlucoseUnits.mmol.rawValue)])
                    
                    readings.append(contentsOf: CommonFunctions.convertGlucoseUnit(value: filteredDates[0].glucoseReading, from: GlucoseUnits.mmol.rawValue))
                case GlucoseUnits.mgdl.rawValue:
                    readings.append(contentsOf: CommonFunctions.convertGlucoseUnit(value: filteredDates[0].glucoseReading*10, from: GlucoseUnits.mgdl.rawValue))
                    reading.glucoseUnit = filteredDates[0].glucoseUnit
                    reading.glucoseReading = filteredDates[0].glucoseReading*10
                    readings.append(reading)
                    readings.append(contentsOf: CommonFunctions.convertGlucoseUnit(value: filteredDates[0].glucoseReading, from: GlucoseUnits.mgdl.rawValue))
                    readings.append(contentsOf: [GlucoseReading(reading: filteredDates[0].glucoseReading, unit: GlucoseUnits.mgdl.rawValue)])
                    
                default:
                    break
                }
            }
            self.readingsArray = readings
            
            self.homeView.statusLabel.text = self.readingLevel.uppercased()
            homeView.updateGlucoseTypeLabel(index: homeView.pageControl.currentPage)
            self.homeView.statusDescriptionLabel.text = StringConstant.bloodSugarTargetRange.value
            self.homeView.statusLabel.isHidden = false
            self.homeView.timeStackView.isHidden = false
            Date.dateFormatter.dateFormat = Date.DateFormat.hmmazzz.rawValue
            Date.dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone? ?? .current
            Date.dateFormatter.setLocalizedDateFormatFromTemplate("hh:mm a")
            var strDate = Date.dateFormatter.string(from: firstReading.createdDate)
            if strDate.components(separatedBy: " ").count == 1 {
                strDate = self.convert24hoursto12hoursformat(strDate: strDate)
            }
            
            self.homeView.setupHeaderText(date: self.currentCalendarDate.localDate(), time: strDate.replace(string: " ", withString: ""))
            if readingLevel.count != 0 && glucoseReadingType.count != 0 {
                homeView.setupStatusLabel(status: readingLevel, readingType: glucoseReadingType)
            }
        } else {
            self.readingsArray = []
            self.homeView.pageControl.numberOfPages = self.readingsArray.count
            
            self.homeView.statusDescriptionLabel.text = StringConstant.thereAreNoReadings.value
            self.homeView.statusLabel.isHidden = true
            
            self.homeView.timeStackView.isHidden = true
            self.homeView.setupHeaderText(date: self.currentCalendarDate.localDate())
        }
        self.homeView.homeReadCollectionView.reloadData()
    }
    
    ///Converts Time String from 24 to 12 hour format
    func convert24hoursto12hoursformat(strDate: String) -> String {
        var timeArray = strDate.replace(string: ":", withString: " ").components(separatedBy: " ")
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
        var timeString = ""
        for (index, timeElement) in timeArray.enumerated() {
            if index == 0 {
                timeString.append("\(timeElement):")
            } else if index == 2 {
                timeString.append("\(timeElement) ")
            } else {
                timeString.append("\(timeElement)")
            }
        }
        return timeString
    }
}
