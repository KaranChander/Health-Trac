//
//  ActivityTimeHeaderViewCell.swift
//   Health Track


import UIKit

class ActivityTimeHeaderViewCell: UITableViewCell {

    // MARK: - IBOutlets
    //===============================================================
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var barSeparatorView: UIView!
    
    // MARK: - Table View Cell Lifecycle
    //===============================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    // MARK: - Functions
    //===============================================================
    
    ///Initial setup for xib
    func initialSetup() {
        setupColors()
        setupFonts()
    }
    
    ///Color setup
    func setupColors() {
        barSeparatorView.backgroundColor = UIColor.init(light: .black, dark: .white)
        timeLabel.textColor = UIColor.init(light: .black, dark: .white)
        self.backgroundColor = UIColor.init(light: .white, dark: .black)
        self.contentView.backgroundColor = UIColor.init(light: .white, dark: .black)
    }
    ///Font setup
    func setupFonts() {
        timeLabel.font = AppFonts.Montserrat_Light.withSize(12)
    }
    
    ///Function tp populate activity time header cell
    func populateCell(date: Date) {
        var strDate = ""
        switch date.hour {
        case 6:
            strDate = "6AM"
        case 12:
            strDate = "12PM"
        case 18:
            strDate = "6PM"
        case 23:
            strDate = "12AM"
        default:
            strDate = "12AM"
        }
        timeLabel.setUpTimeString(text: strDate, baselineOffset: 8, baseSize: 14, superScript: 8, font: .Montserrat_Light)
    }
}
