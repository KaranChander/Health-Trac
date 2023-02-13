//
//  CarbsStepTwoView.swift
//   Health Track


import UIKit

class CarbsStepTwoView: UIView {
    
    // MARK: - IBOutlets
    //========================================================
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var pickerLeadingConstraint: NSLayoutConstraint!
    

    
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
    
    ///Initilal setup of View
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
        unitLabel.font = AppFonts.Montserrat_Medium.withSize(19)
        unitLabel.addCharacterSpacing(of: 0.7)
    }
    
    ///Color setup
    func setupColor() {
        backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        headerLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        unitLabel.textColor = AppColors.black
    }
    
    ///Date Picker setup
    func setupDatePicker() {
        pickerView.subviews[0].subviews[0].subviews[2].backgroundColor = AppColors.heliotrope
        
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        self.pickerView.delegate?.pickerView?(self.pickerView, didSelectRow: 0, inComponent: 0)
        
        self.pickerView.selectRow(0, inComponent: 1, animated: false)
        self.pickerView.delegate?.pickerView?(self.pickerView, didSelectRow: 0, inComponent: 1)
    }
}
// MARK: - UIPickerViewDelegate & UIPickerViewDataSource
//========================================================
extension CarbsStepTwoView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return AppConstants.carbsValues.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return AppConstants.carbsValues[row]
        case 1:
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
            titleData = AppConstants.carbsValues[row]
            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(19)]
//        case 1:
//            titleData = StringConstant.grams.value
//            attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: AppFonts.Montserrat_Medium.withSize(19), NSAttributedString.Key.kern: 0.7]
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
            return 60
        case 1:
            return 100
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.subviews[0].subviews[0].subviews[2].backgroundColor = AppColors.heliotrope
        pickerView.reloadAllComponents()
    }
}

