//
//  ExerciseEntryStepTwoView.swift
//   Health Track


import UIKit

class ExerciseEntryStepTwoView: UIView {
    
    // MARK: - IBOutlets
    //========================================================
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: - ViewLifeCycle
    //========================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    // MARK: - Functions
    //========================================================
    
    ///Initial setu of View
    func initialSetup() {
        self.backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        pickerView.delegate = self
        pickerView.dataSource = self
    }
}

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource
//========================================================
extension ExerciseEntryStepTwoView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return AppConstants.hours.count
        case 1:
            return 1
        case 2:
            return AppConstants.mins.count
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return AppConstants.hours[row]
        case 1:
            return StringConstant.hours.rawValue
        case 2:
            return AppConstants.mins[row]
        case 3:
            return StringConstant.min.rawValue
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        52
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel?
        if view == nil {
            pickerLabel = UILabel()
        }
        
        var color: UIColor = .white
        if pickerView.selectedRow(inComponent: component) == row {
            color = UIColor(light: AppColors.black, dark: AppColors.black)
        } else {
            color = UIColor(light: AppColors.black, dark: AppColors.white)
        }
        var titleData: String = ""
        var attributes: [NSAttributedString.Key: Any] = [:]
        switch component {
        case 0:
            titleData = AppConstants.hours[row]
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(20)]
        case 1:
            titleData = StringConstant.hours.value
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(16)]
        case 2:
            titleData = AppConstants.mins[row]
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(20)]
        case 3:
            titleData = StringConstant.min.value
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(16)]
        default:
            titleData = ""
        }
        let myTitle = NSAttributedString(string: titleData, attributes: attributes)
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .center
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0:
            return 24
        case 1:
            return 80
        case 2:
            return 24
        case 3:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.subviews[0].subviews[0].subviews[2].backgroundColor = AppColors.aquaMarine
        pickerView.reloadAllComponents()
    }
}
