//
//  SettingsSectionHeaderCell.swift
//   Health Track


import UIKit

/// This is the Custom Collection view cell for Settings Section Header in SettingsVC
class SettingsSectionHeaderCell: UITableViewCell {

    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var sectionHeaderSeparatorView: UIView!
    @IBOutlet weak var sectionHeaderLabel: UILabel!
    
    // MARK: - Cell Lifecycle
    //====================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Initial Setup of xib
    func initialSetup() {
        setupFont()
        setupColor()
    }
    
    ///Font setup
    func setupFont() {
        sectionHeaderLabel.font = AppFonts.Montserrat_Light.withSize(19)
    }
    
    ///Color setup
    func setupColor() {
        sectionHeaderSeparatorView.backgroundColor = UIColor(light: AppColors.black, dark: AppColors.white)
        sectionHeaderLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
    
}
