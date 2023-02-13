//
//  SettingsControllerView.swift
//   Health Track


import UIKit

class SettingsControllerView: UIView {

    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var settingsHeaderLabel: UILabel!
    
    // MARK: - Variables
    //===============================
    
    
    // MARK: - ViewLifeCycle
    //===============================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    
    // MARK: - Functions
    //===============================
    
    ///Initial Setup of View
    func initialSetup() {
        setupFont()
        setupColor()
    }
    
    ///Font setup
    func setupFont() {
        settingsHeaderLabel.font = AppFonts.Montserrat_Medium.withSize(30)
        settingsHeaderLabel.addCharacterSpacing(of: -1)
    }
    
    ///Color Setup
    func setupColor() {
        settingsHeaderLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
}

