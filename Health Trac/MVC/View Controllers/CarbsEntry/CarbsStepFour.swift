//
//  CarbsStepFour.swift
//   Health Track


import UIKit
import IQKeyboardManagerSwift

class CarbsStepFour: UIViewController {
    
    //MARK: - IBOutlets
    //=====================================================================
    @IBOutlet var carbsStepFourView: CarbsStepFourView!
    
    var isDescriptionFilled: Bool = false
    var userDescription: String = ""
    
    //MARK: - View Lifecycle
    //=====================================================================
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
        
    ///Assigns values when next button is tapped
    func nextTapped() {
        isDescriptionFilled = carbsStepFourView.checkDescriptionTextField()
        if isDescriptionFilled {
            self.userDescription = self.carbsStepFourView.descriptionTextView.text
        } else {
            self.userDescription = ""
        }
    }
    
}
