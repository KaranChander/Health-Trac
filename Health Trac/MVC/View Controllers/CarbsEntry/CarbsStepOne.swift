//
//  CarbsStepOne.swift
//  Health Track


import UIKit

class CarbsStepOne: UIViewController {
    
    //MARK: - IBOutlets
    //=================================================
    @IBOutlet var carbsStepOneView: CarbsStepOneView!
    
    var date: String = ""
    var createdAt: String = ""
    var createdDateString = ""
    var readingType = ""
    
    //MARK: - View LifeCycle
    //=================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //MARK: - Functions
    //=================================================
    
    ///Assigns values when next button is tapped
    func nextTapped() {
        date = self.carbsStepOneView.datePickerView.formatDate(date: AppConstants.dateCollection[self.carbsStepOneView.datePickerView.selectedRow(inComponent: 0)])
        self.createdAt = "\(date) - \(AppConstants.hours[self.carbsStepOneView.datePickerView.selectedRow(inComponent: 1)]):\(AppConstants.mins[self.carbsStepOneView.datePickerView.selectedRow(inComponent: 3)]) \(AppConstants.meridiem[self.carbsStepOneView.datePickerView.selectedRow(inComponent: 4)])"
        self.createdDateString = self.createdAt.toDate(dateFormat: Date.DateFormat.MMMdyyyyHHmmssa.rawValue)?.convertToString() ?? ""
        self.readingType = ReadingsType.carbs.rawValue
    }
}
