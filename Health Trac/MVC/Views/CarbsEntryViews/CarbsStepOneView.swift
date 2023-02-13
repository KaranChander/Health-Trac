//
//  CarbsStepOneView.swift
//   Health Track

import UIKit

class CarbsStepOneView: UIView {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var datePickerView: DatePickerView!
    @IBOutlet weak var timeColonLabel: UILabel!
    
    // MARK: - Variables
    //====================================================
    var rowDate: Int = 0
    var rowHour: Int = 0
    var rowMin: Int = 0
    var rowMeridiem: Int = 0
    
    // MARK: - Cell Life Cycle
    //====================================================
    override func awakeFromNib() {
        initialSetup()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.setupDatePicker()
        }
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Initial setup of the view
    func initialSetup() {
        setupFont()
        setupColor()
        backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        rowDate = datePickerView.selectedDate()
        rowHour = datePickerView.selectedHour()
        rowMin = datePickerView.selectedMin()
        printDebug(rowHour)
        rowMeridiem = datePickerView.selectedMeridiem()
        datePickerView.delegate = datePickerView
        datePickerView.dataSource = datePickerView
    }
    
    ///Font Setup
    func setupFont() {
        headLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        headLabel.addCharacterSpacing(of: 0.7)
        timeColonLabel.font = AppFonts.Montserrat_Medium.withSize(18)
    }
    
    ///Color Setup
    func setupColor() {
        backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        headLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        timeColonLabel.textColor = AppColors.black
    }
    
    ///Setting up Date Pickers
    func setupDatePicker() {
        datePickerView.subviews[0].subviews[0].subviews[2].backgroundColor = AppColors.heliotrope
        datePickerView.selectedLabelColor = .black
        datePickerView.unselectedLabelColor = .black
        
        self.datePickerView.selectRow(rowDate, inComponent: 0, animated: false)
        self.datePickerView.delegate?.pickerView?(self.datePickerView, didSelectRow: rowDate, inComponent: 0)
        
        self.datePickerView.selectRow(rowHour, inComponent: 1, animated: false)
        self.datePickerView.delegate?.pickerView?(self.datePickerView, didSelectRow: rowHour, inComponent: 1)
        
        self.datePickerView.selectRow(rowMin, inComponent: 3, animated: false)
        self.datePickerView.delegate?.pickerView?(self.datePickerView, didSelectRow: rowHour, inComponent: 3)
        
        self.datePickerView.selectRow(rowMeridiem, inComponent: 4, animated: false)
        self.datePickerView.delegate?.pickerView?(self.datePickerView, didSelectRow: rowHour, inComponent: 4)
    }
}
