//
//  graphTimeSeparatorView.swift
//   Health Track


import UIKit

class GraphTimeSeparatorView: UIView {

    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var separatorLineView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var topTimeLabel: UILabel!
    
    //MARK: - View Lifecycle
    //===============================
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    class func instanceFromNib() -> GraphTimeSeparatorView {
        return UINib(nibName: "GraphTimeSeparatorView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! GraphTimeSeparatorView
    }
    
    //MARK: - Functions
    //===============================
    
    ///Initial setup of xib
    func initialSetup() {
        self.backgroundColor = .clear
        separatorLineView.backgroundColor = UIColor(light: .black, dark: .white).withAlphaComponent(0.15)
        timeLabel.font = AppFonts.Montserrat_Medium.withSize(15)
        topTimeLabel.font = AppFonts.Montserrat_Medium.withSize(15)
        timeLabel.textColor = UIColor(light: .black, dark: .white)
        topTimeLabel.textColor = UIColor(light: .black, dark: .white)
    }
}
