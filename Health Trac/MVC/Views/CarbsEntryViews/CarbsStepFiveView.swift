//
//  CarbsStepFiveView.swift
//   Health Track


import UIKit

class CarbsStepFiveView: UIView {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var dateHeadLabel: UILabel!
    @IBOutlet weak var carbsHeadLabel: UILabel!
    @IBOutlet weak var imagesHeadLabel: UILabel!
    @IBOutlet weak var descriptionHeadLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var carbsImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stepFiveScrollView: UIScrollView!
    @IBOutlet weak var imagesViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageBaseView: UIView!
    
    // MARK: - Variables
    //====================================================
    var imagePreviewBtnTapped: ((UIButton)->Void)?

    var dateLabelText: String = ""
    var timeLabelText: String = ""
    var carbsLabelText: String = ""
    var userDescriptionText: String = ""
    var imageMedia: UIImage = UIImage()
    
    // MARK: - ViewLifeCycle
    //====================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    // MARK: - IBActions
    //====================================================
    @IBAction func imagePreviewButtonTapped(_ sender: UIButton) {
        if let handler = imagePreviewBtnTapped {
            handler(sender)
        }
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Initial setup of View
    func initialSetup() {
        setupFont()
        setupColor()
        carbsImage.round(radius: 20)
    }
    
    ///Setting Label text
    func setupLabelText() {
        dateLabel.text = dateLabelText
        timeLabel.text = timeLabelText
        carbsLabel.text = carbsLabelText
        descriptionLabel.text = userDescriptionText
        carbsImage.image = imageMedia
    }
    
    ///Font Setup
    func setupFont() {
        dateHeadLabel.font = AppFonts.Montserrat_Light.withSize(16)
        carbsHeadLabel.font = AppFonts.Montserrat_Light.withSize(16)
        descriptionHeadLabel.font = AppFonts.Montserrat_Light.withSize(16)
        dateLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        timeLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        imagesHeadLabel.font = AppFonts.Montserrat_Light.withSize(16)
        carbsLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        descriptionLabel.font = AppFonts.Montserrat_Medium.withSize(25)
        dateHeadLabel.addCharacterSpacing(of: 0.5)
        carbsHeadLabel.addCharacterSpacing(of: 0.5)
        descriptionHeadLabel.addCharacterSpacing(of: 0.5)
        dateLabel.addCharacterSpacing(of: 0.7)
        timeLabel.addCharacterSpacing(of: 0.5)
        carbsLabel.addCharacterSpacing(of: 0.7)
        descriptionLabel.addCharacterSpacing(of: 0.7)
    }
    
    ///Color Setup
    func setupColor() {
        backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        dateHeadLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        carbsHeadLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        descriptionHeadLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        dateLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        timeLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        carbsLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        descriptionLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
    
    ///Make ImageBase View
    func makeImageBaseView() {
        self.imagesViewHeight.constant = 0
    }
}
