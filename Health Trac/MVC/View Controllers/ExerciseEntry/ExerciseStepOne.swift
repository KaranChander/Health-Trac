//
//  ExerciseStepOne.swift
//   Health Track


import UIKit

class ExerciseStepOne: UIViewController {

    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var exerciseStepOneView: ExerciseStepOneView!
    
    // MARK: - Variables
    //====================================================
    var model = ReadingsModel()
    var date: String = ""
    var createdAt: String = ""
    var createdDateString: String = ""
    var readingType: String = ""
    
    // MARK: - ViewLifeCycle
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Functions
    //=================================================
    
    ///Sets up data when registering manual reading
    func nextTapped() {
        date = self.exerciseStepOneView.datePickerView.formatDate(date: AppConstants.dateCollection[self.exerciseStepOneView.datePickerView.selectedRow(inComponent: 0)])
        createdAt = "\(date) - \(AppConstants.hours[self.exerciseStepOneView.datePickerView.selectedRow(inComponent: 1)]):\(AppConstants.mins[self.exerciseStepOneView.datePickerView.selectedRow(inComponent: 3)]) \(AppConstants.meridiem[self.exerciseStepOneView.datePickerView.selectedRow(inComponent: 4)])"
        createdDateString = self.createdAt.toDate(dateFormat: Date.DateFormat.MMMdyyyyHHmmssa.rawValue)?.convertToString() ?? ""
        readingType = ReadingsType.exercise.rawValue
    }
}
