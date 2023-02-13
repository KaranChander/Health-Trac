//
//  ScannerTableViewCell.swift
//  Health Track


import UIKit

class ScannerTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    //======================================================
    @IBOutlet weak var deviceLabel: UILabel!
    
    //MARK: - TableView Lifecycle
    //======================================================
    override func awakeFromNib() {
        super.awakeFromNib()

        initialSetup()
    }
    
    //MARK: - Functions
    //======================================================
    
    ///initial setup for xib
    func initialSetup() {
        deviceLabel.font = AppFonts.Montserrat_Medium.withSize(14)
        deviceLabel.textColor = UIColor.init(light: .black, dark: .white)
    }
}
