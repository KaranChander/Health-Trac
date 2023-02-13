//
//  ExerciseStepFourView.swift
//   Health Track


import UIKit

class ExerciseStepFourView: UIView {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var dateHeadLabel: UILabel!
    @IBOutlet weak var durationHeadLabel: UILabel!
    @IBOutlet weak var descriptionHeadLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fromTimeLabel: UILabel!
    @IBOutlet weak var toTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Variables
    //====================================================
    var dateLabelText: String = ""
    var fromTimeLabelText: String = ""
    var toTimeLabelText: String = ""
    var durationLabelText: String = ""
    var userDescriptionText: String = ""
    
    // MARK: - ViewLifeCycle
    //====================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Initial setup odf View
    func initialSetup() {
        setupFont()
        setupColor()
    }
    
    ///Setting up Label text
    func setupLabelText() {
        dateLabel.text = dateLabelText
        fromTimeLabel.text = fromTimeLabelText
        toTimeLabel.text = toTimeLabelText
        durationLabel.text = durationLabelText
        descriptionLabel.text = userDescriptionText
    }
    
    ///Font Setup
    func setupFont() {
        dateHeadLabel.font = AppFonts.Montserrat_Light.withSize(16)
        durationHeadLabel.font = AppFonts.Montserrat_Light.withSize(16)
        descriptionHeadLabel.font = AppFonts.Montserrat_Light.withSize(16)
        dateLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        toTimeLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        fromTimeLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        durationLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        descriptionLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        dateHeadLabel.addCharacterSpacing(of: 0.5)
        durationHeadLabel.addCharacterSpacing(of: 0.5)
        descriptionHeadLabel.addCharacterSpacing(of: 0.5)
        dateLabel.addCharacterSpacing(of: 0.7)
        toTimeLabel.addCharacterSpacing(of: 0.5)
        fromTimeLabel.addCharacterSpacing(of: 0.5)
        durationLabel.addCharacterSpacing(of: 0.7)
        descriptionLabel.addCharacterSpacing(of: 0.7)
    }
    
    ///Color setup
    func setupColor() {
        backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        dateHeadLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        durationHeadLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        descriptionHeadLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        dateLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        toTimeLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        fromTimeLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        durationLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        descriptionLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
}
