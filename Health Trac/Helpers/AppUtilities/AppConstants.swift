//
//  AppConstants.swift
//  NewProject
//
//   Health Track


import Foundation


struct AppConstants {
    
    // For Inapp Subscription
//    static var receiptValidationUrl = AppConstants(rawValue: ReceiptValidationUrl.KeyValue)
    static var k_RealmSchemaVersion: UInt64 = 2
    static let hours = [ "1","2","3","4","5","6","7","8","9","10","11","12"]
    static let hoursWithZero = ["0", "1","2","3","4","5","6","7","8","9","10","11","12"]
    static let mins = [ "00", "01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    static let meridiem: [String] = ["AM", "PM"]
    static var dateCollection = [Date]()
    static var mmolValue: [String] = [String]()
    static var mgValue: [String] = [String]()
    static var salivaMmolValue: [String] = [String]()
    static var salivaMgValue: [String] = [String]()
    static let units = ["\(GlucoseUnits.mmol.rawValue) (Blood)", "\(GlucoseUnits.mgdl.rawValue) (Blood)", "\(GlucoseUnits.mmol.rawValue) (Saliva)", "\(GlucoseUnits.mgdl.rawValue) (Saliva)"]
    static var carbsValues: [String] = [String]()
    static var result: Result?
}
