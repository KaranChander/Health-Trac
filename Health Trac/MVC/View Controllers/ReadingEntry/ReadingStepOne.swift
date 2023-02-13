//
//  ReadingEntryStepOne.swift
//   Health Track


import UIKit

class ReadingStepOne: UIViewController {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var readingStepOneView: ReadingStepOneView!
    
    var date: String = ""
    var createdAt: String = ""
    var createdDateString = ""
    var readingType = ""
    
    // MARK: - View Lifecycle
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Functions
    //=================================================
    
    ///Sets up data when registering manual reading
    func nextTapped() {
        date = self.readingStepOneView.datePickerView.formatDate(date: AppConstants.dateCollection[self.readingStepOneView.datePickerView.selectedRow(inComponent: 0)])
        self.createdAt = "\(date) - \(AppConstants.hours[self.readingStepOneView.datePickerView.selectedRow(inComponent: 1)]):\(AppConstants.mins[self.readingStepOneView.datePickerView.selectedRow(inComponent: 3)]) \(AppConstants.meridiem[self.readingStepOneView.datePickerView.selectedRow(inComponent: 4)])"
        self.createdDateString = self.createdAt.toDate(dateFormat: Date.DateFormat.MMMdyyyyHHmmssa.rawValue)?.convertToString() ?? ""
        self.readingType = ReadingsType.glucose.rawValue
    }
    
}
