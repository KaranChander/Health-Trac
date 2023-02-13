//
//  ReadingStepTwo.swift
//   Health Track

import UIKit

class ReadingStepTwo: UIViewController {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var readingStepwoView: ReadingStepTwoView!
    
    var glucoseReading: Double = 0
    var glucoseUnit: String = ""
    var readingType: String = ""
    var level: String = ""
    
    // MARK: - View Lifecycle
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Functions
    //=================================================
    
    ///Sets up data when registering manual reading
    func nextTapped() {
        self.glucoseReading = Double(self.readingStepwoView.values[self.readingStepwoView.pickerView.selectedRow(inComponent: 0)]) ?? 0.0
        if self.readingStepwoView.pickerView.selectedRow(inComponent: 1) % 2 == 0 {
            glucoseUnit = GlucoseUnits.mmol.rawValue
        } else {
            glucoseUnit = GlucoseUnits.mgdl.rawValue
        }
        if self.readingStepwoView.pickerView.selectedRow(inComponent: 1) == 0 || self.readingStepwoView.pickerView.selectedRow(inComponent: 1) == 1 {
            readingType = glucoseReadingsType.blood.rawValue
        } else {
            readingType = glucoseReadingsType.saliva.rawValue
        }
    }
    
}
