//
//  ExerciseStepTwo.swift
//   Health Track


import UIKit

class ExerciseStepTwo: UIViewController {

    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var exerciseStepTwoView: ExerciseStepTwoView!
    
    // MARK: - Variables
    //====================================================
    var model = ReadingsModel()
    var exerciseHours: Int = 0
    var exerciseMins: Int = 0
    
    // MARK: - ViewLifeCycle
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Functions
    //=================================================
    
    ///Sets up data when registering manual reading
    func nextTapped() {
        self.exerciseHours = Int(AppConstants.hoursWithZero[self.exerciseStepTwoView.pickerView.selectedRow(inComponent: 0)]) ?? 0
        self.exerciseMins = Int(AppConstants.mins[self.exerciseStepTwoView.pickerView.selectedRow(inComponent: 2)]) ?? 0
    }
    
}
