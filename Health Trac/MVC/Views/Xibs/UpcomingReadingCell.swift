//
//  UpcomingReadingCell.swift
//   Health Track


import UIKit

class UpcomingReadingCell: UITableViewCell {

    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var sideBarView: UIView!
    @IBOutlet weak var readingTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Table cell life cycle
    //===================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    // MARK: - Functions
    //===================================================
    
    ///Initial setuo of xib
    func initialSetup() {
        setupFonts()
        setupColors()
        setupBorders()
        setupText()
    }
    
    //Border setup
    func setupBorders() {
        cardView.round(radius: 15)
        sideBarView.round(radius: 4)
    }

    ///Font setup
    func setupFonts() {
        readingTitleLabel.font = AppFonts.Montserrat_Regular.withSize(15)
        timeLabel.font = AppFonts.Montserrat_Medium.withSize(24)
    }
    
    ///Color setup
    func setupColors() {
        cardView.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.4509803922, blue: 0.2823529412, alpha: 0.2598902903)
        timeLabel.textColor = UIColor.init(light: .black, dark: .white)
        sideBarView.backgroundColor = AppColors.pinkishOrange
        readingTitleLabel.textColor = AppColors.pinkishOrange
    }
    
    ///Setup Text
    func setupText() {
        readingTitleLabel.text = StringConstant.upcomingGlucoseReading.value
        var dc: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date())
        dc.hour = (dc.hour ?? 0) + 3
        dc.minute = 0
        dc.second = 0
        dc.nanosecond = 0
        dc.timeZone = .current

        let date = Calendar.current.date(from: dc)
        Date.dateFormatter.dateFormat = Date.DateFormat.hmmazzz.rawValue
        Date.dateFormatter.timeZone = .current
        let strDate = Date.dateFormatter.string(from: date!)
        timeLabel.text = "\(strDate.replace(string: " ", withString: ""))"
        timeLabel.setUpTimeString(text: timeLabel.text ?? "", baselineOffset: 8, baseSize: 24, superScript: 13, font: AppFonts.Montserrat_Medium)
    }
}
