//
//  ReadingStepFour.swift
//   Health Track

import UIKit

class ReadingStepFour: UIViewController {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var readingStepFourView: ReadingStepFourView!
    
    // MARK: - Variables
    //====================================================
    var detailModel = ReadingsDetail()
    
    // MARK: - View Lifecycle
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Functions
    //=================================================
    
    ///Sets up data when registering manual reading
    func setupViewWithData(model: ReadingsModel) {
        let any = model.createdAt.split(separator: "-")
        self.readingStepFourView.dateLabelText = String(any[0])
        self.readingStepFourView.timeLabelText = String(any[1])
        self.readingStepFourView.readingLabelText = "\(String(model.glucoseReading))  \(model.glucoseUnit) (\(model.glucoseReadingType.capitalizedFirst))"
        self.readingStepFourView.userDescriptionText = model.userDescription
        if model.userDescription.isEmpty {
            readingStepFourView.descriptionHeadLabel.isHidden = true
        } else {
            readingStepFourView.descriptionHeadLabel.isHidden = false
        }
        self.readingStepFourView.setupLabelText()
    }
    
    ///Sets up data when comming from activityVC
    func setupViewWithData(model: ReadingsDetail) {
        let any = model.createdAt.split(separator: "-")
        self.readingStepFourView.dateLabelText = String(any[0])
        self.readingStepFourView.timeLabelText = String(any[1])
        self.readingStepFourView.readingLabelText = "\(String(model.glucoseReading))  \(model.glucoseUnit) (\(model.glucoseReadingType.capitalizedFirst))"
        self.readingStepFourView.userDescriptionText = model.userDescription
        if model.userDescription.isEmpty {
            readingStepFourView.descriptionHeadLabel.isHidden = true
        } else {
            readingStepFourView.descriptionHeadLabel.isHidden = false
        }
        self.readingStepFourView.setupLabelText()
    }
    
}
