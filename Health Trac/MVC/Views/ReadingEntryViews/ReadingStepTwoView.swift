//
//  ReadingStepTwoView.swift
//   Health Track


import UIKit

class ReadingStepTwoView: UIView {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerHeight: NSLayoutConstraint!
    @IBOutlet weak var pickerLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    //====================================================
    var values = AppConstants.mmolValue
    
    // MARK: - View LifeCycle
    //====================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.setupDatePicker()
        }
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Initial Setup of View
    func initialSetup() {
        setupFont()
        setupColor()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    ///Font Setup
    func setupFont() {
        headLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        headLabel.addCharacterSpacing(of: 0.7)
    }
    
    ///Color Setup
    func setupColor() {
        backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        headLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
    
    ///Date Picker View
    func setupDatePicker() {
        pickerView.subviews[0].subviews[0].subviews[2].backgroundColor = AppColors.pinkishOrange
        
        self.pickerView.selectRow(21, inComponent: 0, animated: false)
        self.pickerView.delegate?.pickerView?(self.pickerView, didSelectRow: 0, inComponent: 0)
        
        self.pickerView.selectRow(0, inComponent: 1, animated: false)
        self.pickerView.delegate?.pickerView?(self.pickerView, didSelectRow: 0, inComponent: 1)
    }
}

// MARK: -  UIPickerViewDelegate & UIPickerViewDataSource
//=========================================================
extension ReadingStepTwoView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return values.count
        case 1:
            return AppConstants.units.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return values[row]
        case 1:
            return AppConstants.units[row]
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
            color = UIColor(light: AppColors.white, dark: AppColors.white)
        } else {
            color = UIColor(light: AppColors.black, dark: AppColors.white)
        }
        var titleData: String = ""
        var attributes: [NSAttributedString.Key: Any] = [:]
        switch component {
        case 0:
            titleData = values[row]
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(20), NSAttributedString.Key.kern: 0.6]
            pickerLabel!.textAlignment = .right
        case 1:
            titleData = AppConstants.units[row]
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(20), NSAttributedString.Key.kern: 0.6]
            pickerLabel!.textAlignment = .center
        default:
            titleData = ""
        }
        let myTitle = NSAttributedString(string: titleData, attributes: attributes)
        pickerLabel!.attributedText = myTitle
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0:
            return 80
        case 1:
            return 200
        default:
            return 0
        }
       }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.selectedRow(inComponent: 1) == 0 {
            values = AppConstants.mmolValue
        } else if pickerView.selectedRow(inComponent: 1) == 1 {
            values = AppConstants.mgValue
        } else if pickerView.selectedRow(inComponent: 1) == 2 {
            values = AppConstants.salivaMmolValue
        } else {
            values = AppConstants.salivaMgValue
        }
        pickerView.reloadAllComponents()
    }
}

