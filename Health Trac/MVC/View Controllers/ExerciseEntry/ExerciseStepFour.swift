//
//  ExerciseStepFour.swift
//   Health Track


import UIKit

class ExerciseStepFour: UIViewController {

    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var exerciseStepFourView: ExerciseStepFourView!
    
    var userDescription: String = ""
    
    // MARK: - View Life Cycle
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Functions
    //=================================================
    
    ///Sets up data when registering manual reading
    func setupViewWithData(model: ReadingsModel) {
        let any = model.createdAt.split(separator: "-")
        self.exerciseStepFourView.dateLabelText = String(any[0])
        self.exerciseStepFourView.fromTimeLabelText = String(any[1])
        self.exerciseStepFourView.toTimeLabelText = "to \(String(any[1]).addTime(hours: model.exerciseReading.hours, min: model.exerciseReading.minutes, isMeridiemNeeded: true))"
        if model.exerciseReading.hours == 0 {
            self.exerciseStepFourView.durationLabelText = "\(model.exerciseReading.minutes) min"
        }else if model.exerciseReading.hours == 1 {
            self.exerciseStepFourView.durationLabelText = "\(model.exerciseReading.hours) hour \(model.exerciseReading.minutes) min"
        } else {
            self.exerciseStepFourView.durationLabelText = "\(model.exerciseReading.hours) hours \(model.exerciseReading.minutes) min"
        }
        self.exerciseStepFourView.userDescriptionText = model.userDescription
        if model.userDescription.isEmpty {
            exerciseStepFourView.descriptionHeadLabel.isHidden = true
        } else {
            exerciseStepFourView.descriptionHeadLabel.isHidden = false
        }
        self.exerciseStepFourView.setupLabelText()
    }
    
    ///Sets up data when comming from activityVC
    func setupViewWithData(model: ReadingsDetail) {
        let any = model.createdAt.split(separator: "-")
        self.exerciseStepFourView.dateLabelText = String(any[0])
        self.exerciseStepFourView.fromTimeLabelText = String(any[1])
        self.exerciseStepFourView.toTimeLabelText = "to \(String(any[1]).addTime(hours: model.exerciseReading?.hours ?? 0, min: model.exerciseReading?.minutes ?? 0, isMeridiemNeeded: true))"
        if model.exerciseReading?.hours == 0 {
            self.exerciseStepFourView.durationLabelText = "\(model.exerciseReading?.minutes ?? 0) min"
        }else if model.exerciseReading?.hours == 1 {
            self.exerciseStepFourView.durationLabelText = "\(model.exerciseReading?.hours ?? 0) hour \(model.exerciseReading?.minutes ?? 0) min"
        } else {
            self.exerciseStepFourView.durationLabelText = "\(model.exerciseReading?.hours ?? 0) hours \(model.exerciseReading?.minutes ?? 0) min"
        }
        self.exerciseStepFourView.userDescriptionText = model.userDescription
        if model.userDescription.isEmpty {
            exerciseStepFourView.descriptionHeadLabel.isHidden = true
        } else {
            exerciseStepFourView.descriptionHeadLabel.isHidden = false
        }
        self.exerciseStepFourView.setupLabelText()
    }
}
