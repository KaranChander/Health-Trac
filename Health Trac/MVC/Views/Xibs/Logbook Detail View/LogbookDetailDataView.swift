//
//  LogbookDetailDataView.swift
//   Health Track


import UIKit

class LogbookDetailDataView: UIView {

    // MARK: - IBOutlets
    //==================================================
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: - Variables
    //==================================================

    // MARK: - ViewLifeCycle
    //===============================
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    class func instanceFromNib() -> LogbookDetailDataView {
        return UINib(nibName: "LogbookDetailDataView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LogbookDetailDataView
    }

    // MARK: - Functions
    //==================================
    
    ///Initial setup of xib
    func initialSetup() {
        setupFont()
        setupColor()
        sideView.layer.cornerRadius = 4
    }
    
    ///Font setup
    func setupFont() {
        self.headLabel.font = AppFonts.Montserrat_Medium.withSize(16)
        self.timeLabel.font = AppFonts.Montserrat_Regular.withSize(20)
        self.statusLabel.font = AppFonts.Montserrat_Regular.withSize(20)
        self.readingLabel.font = AppFonts.Montserrat_Regular.withSize(20)
    }
    
    ///Color setup
    func setupColor() {
        self.readingLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        self.statusLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
}
