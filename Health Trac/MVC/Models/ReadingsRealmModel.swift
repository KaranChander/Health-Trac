//
//  ReadingsModel.swift
//   Health Track

import Realm
import RealmSwift
import TrueTime
import Foundation

enum ReadingsType: String {
    case glucose
    case carbs
    case exercise
}

enum GlucoseUnits: String {
    case mmol = "mmol/L"
    case mgdl = "mg/dL"
}

import Foundation
final class ReadingsDetail: Object {
    // MARK: - Properties
    @objc dynamic var id: Int = 0
    @objc dynamic var createdAt: String = ""
    @objc dynamic var createdDateString: String = ""
    @objc dynamic var readingType: String = ""
    @objc dynamic var glucoseReading: Double = 0.0
    @objc dynamic var glucoseUnit: String = ""
    @objc dynamic var exerciseReading: ExerciseReading? = nil
    @objc dynamic var carbsReading: String = ""
    @objc dynamic var carbsMedia: String = ""
    @objc dynamic var userDescription: String = ""
    @objc dynamic var glucoseReadingType: String = ""
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var createdDate: Date {
        let date = createdAt.toDate(dateFormat: Date.DateFormat.MMMdyyyyHHmmssa.rawValue)
        return date ?? Date()
    }
    
    var readingLevel: String {
        if glucoseReadingType == glucoseReadingsType.blood.rawValue {
            if self.glucoseUnit == GlucoseUnits.mmol.rawValue {
                if glucoseReading < 3.9 {
                    return glucoseLevel.low.rawValue
                } else if 3.9 <= glucoseReading && glucoseReading < 10 {
                    return glucoseLevel.normal.rawValue
                } else if self.glucoseReading >= 10 {
                    return glucoseLevel.high.rawValue
                }
            } else {
                if glucoseReading < 70 {
                    return glucoseLevel.low.rawValue
                } else if 70 <= self.glucoseReading && self.glucoseReading < 180 {
                    return glucoseLevel.normal.rawValue
                } else if glucoseReading >= 180 {
                    return glucoseLevel.high.rawValue
                }
            }
        } else {
            if self.glucoseUnit == GlucoseUnits.mmol.rawValue {
                if glucoseReading < 0.39 {
                    return glucoseLevel.low.rawValue
                } else if 0.39 <= glucoseReading && glucoseReading < 1 {
                    return glucoseLevel.normal.rawValue
                } else if self.glucoseReading >= 1 {
                    return glucoseLevel.high.rawValue
                }
            } else {
                if glucoseReading < 7 {
                    return glucoseLevel.low.rawValue
                } else if 7 <= self.glucoseReading && self.glucoseReading < 18 {
                    return glucoseLevel.normal.rawValue
                } else if glucoseReading >= 18 {
                    return glucoseLevel.high.rawValue
                }
            }
        }
        return glucoseLevel.high.rawValue
    }
    
    class func createId() -> Int? {
        do {
            let configuration = Realm.Configuration(encryptionKey: AppDelegate.shared.getKey() as Data, schemaVersion: AppConstants.k_RealmSchemaVersion)
            
            let realm = try Realm(configuration: configuration)
            let id = (realm.objects(ReadingsDetail.self).max(ofProperty: "id") as Int? ?? 0) + 1
            return id
        } catch {
            printDebug("Realm error")
            return nil
        }
    }
    
    class func initializeWith(readingsModel: ReadingsModel) -> ReadingsDetail {
        let readingModel = ReadingsDetail()
        readingModel.id = readingsModel.id
        readingModel.createdAt = readingsModel.createdAt
        readingModel.createdDateString = readingsModel.createdDateString
        readingModel.readingType = readingsModel.readingType
        readingModel.glucoseReading = readingsModel.glucoseReading
        readingModel.glucoseUnit = readingsModel.glucoseUnit
        readingModel.exerciseReading = readingsModel.exerciseReading
        readingModel.carbsReading = readingsModel.carbsReading
        readingModel.carbsMedia = readingsModel.carbsMedia
        readingModel.userDescription = readingsModel.userDescription
        readingModel.glucoseReadingType = readingsModel.glucoseReadingType
        return readingModel
    }
    
    // Parse & Write Inbox Data for the given localChatId
    class func saveReadingData(readingsModel: ReadingsModel) -> ReadingsDetail {

        let realmReadingModel = ReadingsDetail.initializeWith(readingsModel: readingsModel)
        
        ReadingsDetail.writeReadingsDataToDB(readingModel: realmReadingModel)
        
        return realmReadingModel
    }
    
}

// MARK: - Last Message info
class ExerciseReading: Object {
    
    // MARK: - Properties
    @objc dynamic var hours: Int = 0
    @objc dynamic var minutes: Int = 0
    
    class func instantiateWith(exerciseReading: [String: Any]) -> ExerciseReading {
        let exerciseReading = ExerciseReading()
        if let exerciseHours = exerciseReading["exerciseHours"] as? Int {
            exerciseReading.hours = exerciseHours
        }
        if let exerciseMiutes = exerciseReading["exerciseMinutes"] as? Int {
            exerciseReading.minutes = exerciseMiutes
        }
        return exerciseReading
    }
}

// MARK: - Write Operation
extension ReadingsDetail {
    // Save Chat thread Data to local DB
    class func writeReadingsDataToDB(readingModel: ReadingsDetail) {
        do {
            let configuration = Realm.Configuration(encryptionKey: AppDelegate.shared.getKey() as Data, schemaVersion: AppConstants.k_RealmSchemaVersion)
            
            
            let realm = try Realm(configuration: configuration)
            do {
                try realm.write {
                    realm.add(readingModel, update: .modified)
                }
            } catch let error {
                printDebug("Error Writting chatModel: " + error.localizedDescription)
            }
        } catch let error {
            printDebug("Error initailizing DB: " + error.localizedDescription)
        }
    }
    
    class func getDirectReadingList() -> [ReadingsDetail]? {
        do {
            let configuration = Realm.Configuration(encryptionKey: AppDelegate.shared.getKey() as Data, schemaVersion: AppConstants.k_RealmSchemaVersion)
            let realm = try Realm(configuration: configuration)
            //            _ = TrueTimeManager.shared.currentTime.minus(months: 1).millisecondsSince1970
            //            let predicate = NSPredicate(format: "chatType = %@ AND isChatIgnored = false AND createdAt >= %@", ChatType.direct.rawValue, NSNumber(value: createdAt))
            let readingArray = realm.objects(ReadingsDetail.self).sorted(byKeyPath: "createdDateString", ascending: false)
            return Array(readingArray)
        } catch let error {
            printDebug(error.localizedDescription)
        }
        return nil
    }
    
    class func getSeparateReading() -> (glucose: [ReadingsDetail], exercise: [ReadingsDetail], carbs: [ReadingsDetail])? {
        do {
            let configuration = Realm.Configuration(encryptionKey: AppDelegate.shared.getKey() as Data, schemaVersion: AppConstants.k_RealmSchemaVersion)
            let realm = try Realm(configuration: configuration)
            let glucoseReading = realm.objects(ReadingsDetail.self).sorted(byKeyPath: "createdDateString", ascending: false).filter("readingType = '\(ReadingsType.glucose.rawValue)'")
            let exerciseReading = realm.objects(ReadingsDetail.self).sorted(byKeyPath: "createdDateString", ascending: false).filter("readingType = '\(ReadingsType.exercise.rawValue)'")
            let carbsReading = realm.objects(ReadingsDetail.self).sorted(byKeyPath: "createdDateString", ascending: false).filter("readingType = '\(ReadingsType.carbs.rawValue)'")
            return (glucose: Array(glucoseReading), exercise: Array(exerciseReading), carbs: Array(carbsReading))
        } catch let error {
            printDebug(error.localizedDescription)
        }
        return nil
    }
    
}
