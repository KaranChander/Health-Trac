//
//  ActivityView.swift
//   Health Track

import UIKit

class ActivityView: UIView {
    
    // MARK: - IBOutlets
    //===============================================================
    @IBOutlet weak var activityTableView: UITableView!
    @IBOutlet weak var calenderButton: UIButton!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headerBlurView: UIVisualEffectView!

    // MARK: - Properties
    //===============================
    var calenderBtnTapped: ((UIButton) -> Void)?
    
    // MARK: - ViewLifeCycle
    //===============================
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    // MARK: - IBActions
    //===============================
    @IBAction func calenderButtonTapped(_ sender: UIButton) {
        if let handler = self.calenderBtnTapped {
            handler(sender)
        }
        sender.isSelected = !sender.isSelected
    }
    
    // MARK: - Functions
    //========================================================
    
    ///Initial Setup of View
    func initialSetup() {
        setupFont()
        setupColor()
        setupHeaderText()
        headerBlurView.isHidden = true
    }
    
    ///Font Setup
    func setupFont() {
        dayLabel.font = AppFonts.Montserrat_Light.withSize(21)
        dateLabel.font = AppFonts.Montserrat_Medium.withSize(28)
        dayLabel.addCharacterSpacing(of: -0.5)
        dateLabel.addCharacterSpacing(of: -0.59)
    }
    
    ///Color Setup
    func setupColor() {
        self.backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        dayLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        dateLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
    
    ///Sets up Header Text
    func setupHeaderText(date: Date = Date().localDate()) {
        self.dateLabel.text = date.convertToFormattedString()
        self.dayLabel.text = date.timeAgoSince
    }
}
