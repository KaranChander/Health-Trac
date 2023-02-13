//
//  SettingsCell.swift
//  Health Track


import UIKit

// MARK: - Protocol DarkModeToggleDelegate
//====================================================
protocol DarkModeToggleDelegate {
    func darkModeToggled(index: IndexPath, isOn: Bool)
}

/// This is the Custom Collection view cell for Settings Row in SettingsVC
class SettingsCell: UITableViewCell {

    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var settingsTitleLabel: UILabel!
    @IBOutlet weak var settingsToggleSwitch: UISwitch!
    @IBOutlet weak var settingsArrow: UIImageView!
    @IBOutlet weak var settingsSubLabel: UILabel!
    
    // MARK: - Variables
    //====================================================
    var darkkModeDelegate: DarkModeToggleDelegate?
    var index: IndexPath?
    
    // MARK: - Cell Lifecycle
    //====================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    // MARK: - IBActions
    //====================================================
    @IBAction func toggleTapped(_ sender: UISwitch) {
        if sender.isOn {
            settingsToggleSwitch.thumbTintColor = AppColors.pinkishOrange
        } else {
            settingsToggleSwitch.thumbTintColor = AppColors.gray
        }
        if let index = index {
            darkkModeDelegate?.darkModeToggled(index: index, isOn: sender.isOn)
        }
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Initial setup for xib
    func initialSetup() {
        setupFont()
        setupColor()
    }
    
    ///Font setup
    func setupFont() {
        settingsTitleLabel.font = AppFonts.Montserrat_Light.withSize(23)
        settingsSubLabel.font = AppFonts.Montserrat_Light.withSize(18)
        settingsTitleLabel.addCharacterSpacing(of: -0.5)
    }
    
    ///Color setup
    func setupColor() {
        self.contentView.backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        settingsTitleLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        settingsSubLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        settingsArrow.tintColor = UIColor(light: AppColors.black, dark: AppColors.white)
        settingsToggleSwitch.onTintColor = AppColors.pinkishOrange.withAlphaComponent(0.3)
        settingsToggleSwitch.thumbTintColor = AppColors.pinkishOrange
    }
    
    ///Function to populate settings custom cell
    func populateCell(model: [Int : [SettingsModel]], indexPath: IndexPath) {
        self.settingsTitleLabel.text = model[indexPath.section]?[indexPath.row].title
        self.settingsArrow.isHidden = !(model[indexPath.section]?[indexPath.row].isArrow ?? true)
        self.settingsToggleSwitch.isHidden = !(model[indexPath.section]?[indexPath.row].isSwitch ?? true)
        self.settingsSubLabel.isHidden = !(model[indexPath.section]?[indexPath.row].isSubTitle ?? true)
        self.settingsSubLabel.text = model[indexPath.section]?[indexPath.row].subTitleLabel
        self.settingsToggleSwitch.isOn = model[indexPath.section]?[indexPath.row].isSwitchOn ?? true
        self.index = indexPath
    }
}
