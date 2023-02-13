//
//  ReadingStepFourView.swift
//   Health Track

import UIKit

class ReadingStepFourView: UIView {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var dateHeadLabel: UILabel!
    @IBOutlet weak var readingHeadLabel: UILabel!
    @IBOutlet weak var descriptionHeadLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Variables
    //====================================================
    var dateLabelText: String = ""
    var timeLabelText: String = ""
    var readingLabelText: String = ""
    var userDescriptionText: String = ""
    
    // MARK: - ViewLifeCycle
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
    }
    
    ///Setting up of Label Text
    func setupLabelText() {
        dateLabel.text = dateLabelText
        timeLabel.text = timeLabelText
        readingLabel.text = readingLabelText
        descriptionLabel.text = userDescriptionText
    }
    
    ///Font Setup
    func setupFont() {
        dateHeadLabel.font = AppFonts.Montserrat_Light.withSize(16)
        readingHeadLabel.font = AppFonts.Montserrat_Light.withSize(16)
        descriptionHeadLabel.font = AppFonts.Montserrat_Light.withSize(16)
        dateLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        timeLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        readingLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        descriptionLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        dateHeadLabel.addCharacterSpacing(of: 0.5)
        readingHeadLabel.addCharacterSpacing(of: 0.5)
        descriptionHeadLabel.addCharacterSpacing(of: 0.5)
        dateLabel.addCharacterSpacing(of: 0.7)
        timeLabel.addCharacterSpacing(of: 0.5)
        readingLabel.addCharacterSpacing(of: 0.7)
        descriptionLabel.addCharacterSpacing(of: 0.7)
    }
    
    ///Color Setup
    func setupColor() {
        backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        dateHeadLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        readingHeadLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        descriptionHeadLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        dateLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        timeLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        readingLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        descriptionLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
}
