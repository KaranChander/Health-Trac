//
//  ReadingsModel.swift
//   Health Track

import Foundation
import  UIKit

struct ReadingsModel {
    var id: Int
    var createdAt: String
    var readingType: String
    var glucoseReading: Double
    var glucoseUnit: String
    var createdDateString: String
    var exerciseReading: ExerciseReading
    var carbsReading: String
    var carbsMedia: String
    var userDescription: String
    var glucoseReadingType: String

    
    init() {
        id = 0
        createdAt = ""
        readingType = ""
        glucoseReading = 0.0
        glucoseUnit = ""
        exerciseReading = ExerciseReading()
        carbsReading = ""
        carbsMedia = ""
        userDescription = ""
        createdDateString = ""
        glucoseReadingType = ""
    }
}


struct GlucoseReading {
    var glucoseReading: Double
    var glucoseUnit: String
    
    init() {
        glucoseReading = 0.0
        glucoseUnit = ""
    }
    
    init(reading: Double, unit: String) {
        glucoseReading = reading
        glucoseUnit = unit
    }
}

struct AutomaticGlucoseReading {
    var stateOneCompleted: Bool
    var stateTwoCompleted: Bool
    var glucoseUnit: String
    var glucoseReading: Double
    
    init() {
        stateOneCompleted = false
        stateTwoCompleted = false
        glucoseUnit = ""
        glucoseReading = 0.0
    }

}

enum glucoseReadingsType: String {
//    case saliva = "Saliva Glucose"
    case blood = "Blood Glucose"
}

enum glucoseLevel: String {
    case low
    case normal
    case high
}

enum glucoseLevelDescription: String {
    case low = "Your blood sugar is below your target range"
    case normal = "Your blood sugar is within your target range"
    case high = "Your blood sugar is above your target range"
}


//TRIAL
// MARK: - ResultElement
struct ResultElement: Codable {
    let day: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let time, readingType, glucoseReading, glucoseUnit: String
    let exerciseReading: ExerciseRead
    let carbsReading, carbsMedia, userDescription, glucoseReadingType: String
}

// MARK: - ExerciseReading
struct ExerciseRead: Codable {
    let hours, minutes: String
}

typealias Result = [ResultElement]
