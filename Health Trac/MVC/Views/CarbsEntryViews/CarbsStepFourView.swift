//
//  CarbsStepFourView.swift
//   Health Track


import UIKit

class CarbsStepFourView: UIView {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var blurTextViewBgView: UIVisualEffectView!
    @IBOutlet weak var blurChildView: UIView!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Variables
    //====================================================
    
    // MARK: - View LifeCycle
    //====================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Initial setup of View
    func initialSetup() {
        setupFont()
        setupColor()
        blurTextViewBgView.cornerRadius = 15
        blurChildView.layer.cornerRadius = 15
        descriptionTextView.delegate = self
        descriptionTextView.attributedText = NSAttributedString(string: StringConstant.placeholder.value, attributes: [
                                                                    NSAttributedString.Key.font: AppFonts.Montserrat_Regular.withSize(18), NSAttributedString.Key.kern: 2,NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        descriptionTextView.selectedTextRange = descriptionTextView.textRange(from: descriptionTextView.beginningOfDocument, to: descriptionTextView.endOfDocument)
    }
    
    ///Font setup
    func setupFont() {
        headLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        headLabel.addCharacterSpacing(of: 0.7)
    }
    
    ///Color setup
    func setupColor() {
        backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        headLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
    
    func checkDescriptionTextField() -> Bool {
        if self.descriptionTextView.text == StringConstant.placeholder.value || self.descriptionTextView.text.isEmpty {
//            CommonFunctions.showToastWithMessage(StringConstant.pleaseEnterDescription.value)
            return false
        } else {
            return true
        }
    }
}

// MARK: - UITextViewDelegate
//====================================================
extension CarbsStepFourView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText: NSString = textView.text! as NSString
        let updatedText = currentText.replacingCharacters(in: range, with:text)
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        if updatedText.isEmpty {
            textView.text = StringConstant.placeholder.value
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            return false
        } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            if AppUserDefaults.value(forKey: .darkModeEnable).rawValue as? Bool ?? false {
                textView.textColor = UIColor.white
            } else {
                textView.textColor = UIColor.black
            }
        } else if textView.textColor == UIColor.white || textView.textColor == UIColor.black {
            
            return textView.textLimit(newText: text, limit: 50)
        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
}

