//
//  AutomaticGlucoseReadingView.swift
//   Health Track


import UIKit

class DeviceScannerView: UIView {

    //MARK: - IBOutlets
    //================================================
    @IBOutlet weak var navigationBarContainer: NavigationBar!
    @IBOutlet weak var bluetoothDevicesTableView: UITableView!
    @IBOutlet weak var chooseDeviceTitleLabel: UILabel!
    @IBOutlet weak var manualGlucoseButton: UIButton!
    @IBOutlet weak var buttonUnderlineView: UIView!
    
    // MARK: - Variables
    //====================================================
    var manualGlucoseBtnTapped: ((UIButton)->Void)?

    // MARK: - ViewLifeCycle
    //===============================
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    // MARK: - IBActions
    //===============================
    @IBAction func manualGlucoseButtonTapped(_ sender: UIButton) {
        if let handler = self.manualGlucoseBtnTapped {
            handler(sender)
        }
    }
    
    // MARK: - Functions
    //===============================
    
    ///Initial setup of View
    func initialSetup() {
        setupText()
        setupFonts()
        setupColors()
    }
    
    ///Sets up text title
    func setupText() {
        chooseDeviceTitleLabel.text = StringConstant.selectYourGBSScannerDevice.value
        self.manualGlucoseButton.setTitle(StringConstant.manualGlucoseEntry.value, for: .normal)
    }
    
    ///Font Setup
    func setupFonts() {
        chooseDeviceTitleLabel.font = AppFonts.Montserrat_Semibold.withSize(18)
        manualGlucoseButton.titleLabel?.font = AppFonts.Montserrat_Light.withSize(18)

    }
    
    ///Color Setup
    func setupColors() {
        chooseDeviceTitleLabel.textColor = UIColor.init(light: .black, dark: .white)
        manualGlucoseButton.setTitleColor(UIColor.init(light: .black, dark: .white), for: .normal)
        buttonUnderlineView.backgroundColor = UIColor.init(light: .black, dark: .white)
    }
}
