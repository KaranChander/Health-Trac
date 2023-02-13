//
//  CarbsStepTwo.swift
//   Health Track


import UIKit

class CarbsStepTwo: UIViewController {
    
    //MARK: - IBOutlets
    //=================================================
    @IBOutlet var carbsStepTwoView: CarbsStepTwoView!
    
    var carbsReading = ""
    
    //MARK: - View LifeCycle
    //=================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    //MARK: - Functions
    //=================================================
    
    ///Assigns values when next button is tapped
    func nextTapped() {
        self.carbsReading = AppConstants.carbsValues[self.carbsStepTwoView.pickerView.selectedRow(inComponent: 0)]
    }
}
