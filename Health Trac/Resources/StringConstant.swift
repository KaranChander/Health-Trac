//
//  StringConstant.swift
//  Health Track
//
//  Created by Karan on 27/05/19.
//

import Foundation

enum StringConstant: String {
    

    // MARK: - App Title
    //===================
    case appTitle = "appTitle"


    // MARK: - UIViewController Extension
    //=================================
    case chooseOptions = "ChooseOptions"
    case camera = "Camera"
    case cameraNotAvailable = "CameraNotAvailable"
    case chooseImage = "ChooseImage"
    case chooseFromGallery = "ChooseFromGallery"
    case takePhoto = "TakePhoto"
    case cancel = "Cancel"
    case alert = "Alert"
    case restrictedFromUsingCamera = "RestrictedFromUsingCamera"
    case changePrivacySettingAndAllowAccessToCamera = "ChangePrivacySettingAndAllowAccessToCamera"
    case restrictedFromUsingLibrary = "RestrictedFromUsingLibrary"
    case changePrivacySettingAndAllowAccessToLibrary = "ChangePrivacySettingAndAllowAccessToLibrary"
    case removePhoto = "removePhoto"
    case openCameraGallery = "openCameraGallery"
    case changePrivacySettingAndAllowAccessToLocation = "ChangePrivacySettingAndAllowAccessToLocation"
    case filterByCurrentStatus = "filterByCurrentStatus"
    case pleaseSelectStatus = "pleaseSelectStatus"
    case ok = "ok" 
    case settings = "settings"
    case demoVersion = "demoVersion"
    case pleaseEnterDescription = "pleaseEnterDescription"
    case noActivityDateFound = "noActivityDateFound"

    // MARK: - SettingsVC
    //=====================
    case defaultUnits = "Default Units"
    case mmolL = "mmol/L"
    case notifications = "Notifications"
    case stripDetection = "Strip Detection"
    case language = "Language"
    case english = "English"
    case darkMode = "Dark Mode"
    case backgroungRefresh = "Background Refresh"
    case deviceSettings = "Device Settings"
    case appPreference = "App Preferences"
    
    // MARK: - ExerciseStepTwo
    //=====================
    case hours = "hours"
    case min = "min"
    
    //MARK: - ReadingStepThree
    case placeholder = "Please type here..."
    case noDescription = "No description added"
    
    //MARK: - CArbs Step Two
    case grams = "Grams"
    
    //MARK: - Carbs Step Three
    case cameraPermissionDenied = "Camera Permission Denied"
    case skipToNextStep = "You will be skipped to next step or in case you want to toggle camera permission click settings"
    
    //MARK: - Manual Entry Steps
    case oneByFour = "1 /4"
    case twoByFour = "2 /4"
    case threeByFour = "3 /4"
    case fourByFour = "4 /4"
    
    case oneByFive = "1 /5"
    case twoByFive = "2 /5"
    case threeByFive = "3 /5"
    case fourByFive = "4 /5"
    case fiveByFive = "5 /5"
    
    // MARK: - No Internet
    //=====================
    case sorry = "Sorry"
    case pleaseTryAgain = "PleaseTryAgain"
    case pleaseCheckInternetConnection = "PleaseCheckInternetConnection"
    case noInternetAvailable = "noInternetAvailable"
    case retry = "retry"
    
    // TAB bar
    case reading = "reading"
    case exercise = "exercise"
    case carbs = "carbs"


    
    // MARK: - Activity VC
    //=====================
    case carbohydrates = "carbohydrates"
    case glucoseReading = "glucoseReading"
    case upcomingGlucoseReading = "upcomingGlucoseReading"
    
    // MARK: - Home VC
    //=====================
    case thereAreNoReadings = "thereAreNoReadings"
    case bloodSugarTargetRange = "bloodSugarTargetRange"
   
    // MARK: - LogBook VC
    //=====================
    case glucose = "glucose"
    case minutes = "minutes"
    case normal = "normal"
    case readings = "readings"
    case normalCapitalized = "NORMAL"

    // MARK: - EmptyDataSetConstant
    //===========================
    case noResultFound

    //MARK: - Notification Names
    case updateHomeView = "updateHomeView"
    case hidePopUp = "hidePopUp"
    case updateLogBook = "updateLogBook"
    case comingFromActivity = "comingFromActivity"
    
    // MARK: - Automatic Glucose reading
    //=====================================

    case selectDevice = "selectDevice"
    case selectYourGBSScannerDevice = "selectYourGBSScannerDevice"
    case processing = "processing"
    case manualGlucoseEntry = "manualGlucoseEntry"
    case discardChanges = "discardChanges"
    case discardChangesDesc = "discardChangesDesc"
    case readingReceived = "readingReceived"
}

extension StringConstant {
    var value: String {
        return self.rawValue.localized
    }
}
