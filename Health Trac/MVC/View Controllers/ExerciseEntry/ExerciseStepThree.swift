//
//  ExerciseStepThree.swift
//   Health Track


import UIKit
import IQKeyboardManagerSwift

class ExerciseStepThree: UIViewController {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var exerciseStepThreeView: ExerciseStepThreeView!
    
    // MARK: - Variables
    //====================================================
    var model = ReadingsModel()
    var isDescriptionFilled: Bool = false
    var userDescription: String = ""
    
    // MARK: - ViewController Life cycle
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
    }
    
    //MARK: - Functions
    //=================================================
    
    ///Sets up data when registering manual reading
    func nextTapped() {
        isDescriptionFilled = exerciseStepThreeView.checkDescriptionTextField()
        if isDescriptionFilled {
            self.userDescription = self.exerciseStepThreeView.descriptionTextView.text
        } else {
            self.userDescription = ""
        }
    }
}
