//
//  ExerciseStepTwoView.swift
//   Health Track


import UIKit

class ExerciseStepTwoView: UIView {

    // MARK: - IBOutlets
    //========================================================
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var pickerLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    //====================================================
    
    // MARK: - ViewLifeCycle
    //========================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.setupDatePicker()
        }
    }

    // MARK: - Functions
    //========================================================
    
    ///Initial setup of view
    func initialSetup() {
        setupFont()
        setupColor()
        self.backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    ///Font setup
    func setupFont() {
        headerLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        headerLabel.addCharacterSpacing(of: 0.7)
        hourLabel.font = AppFonts.Montserrat_Medium.withSize(15)
        hourLabel.addCharacterSpacing(of: 0.7)
        minuteLabel.font = AppFonts.Montserrat_Medium.withSize(15)
        minuteLabel.addCharacterSpacing(of: 0.7)
    }
    
    ///Color Setup
    func setupColor() {
        backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        headerLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        hourLabel.textColor = AppColors.black
        minuteLabel.textColor = AppColors.black
    }
    
    ///Date Picker Setup
    func setupDatePicker() {
        pickerView.subviews[0].subviews[0].subviews[2].backgroundColor = AppColors.aquaMarine
        
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        self.pickerView.delegate?.pickerView?(self.pickerView, didSelectRow: 0, inComponent: 0)
        
        self.pickerView.selectRow(0, inComponent: 1, animated: false)
        self.pickerView.delegate?.pickerView?(self.pickerView, didSelectRow: 0, inComponent: 1)
        
        self.pickerView.selectRow(0, inComponent: 2, animated: false)
        self.pickerView.delegate?.pickerView?(self.pickerView, didSelectRow: 0, inComponent: 1)
        
        self.pickerView.selectRow(0, inComponent: 3, animated: false)
        self.pickerView.delegate?.pickerView?(self.pickerView, didSelectRow: 0, inComponent: 1)
    }
}

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource
//========================================================
extension ExerciseStepTwoView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return AppConstants.hoursWithZero.count
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
            return AppConstants.hoursWithZero[row]
        case 1:
            return ""
        case 2:
            return AppConstants.mins[row]
        case 3:
            return ""
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
            titleData = AppConstants.hoursWithZero[row]
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(19)]
//        case 1:
//            titleData = StringConstant.hours.value
//            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(15), NSAttributedString.Key.kern: 0.7]
        case 2:
            titleData = AppConstants.mins[row]
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(19)]
//        case 3:
//            titleData = StringConstant.min.value
//            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(15), NSAttributedString.Key.kern: 0.7]
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
            return 36
        case 1:
            return 84
        case 2:
            return 28
        case 3:
            return 56
        default:
            return 0
        }
       }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.selectedRow(inComponent: 0) == 0 && pickerView.selectedRow(inComponent: 2) == 0 {
            pickerView.selectRow(1, inComponent: 2, animated: true)
        }
        pickerView.subviews[0].subviews[0].subviews[2].backgroundColor = AppColors.aquaMarine
        pickerView.reloadAllComponents()
    }
}

