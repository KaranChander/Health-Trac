//
//  AutomaticGlucoseReadingView.swift
//   Health Track


import UIKit

class AutomaticGlucoseReadingView: UIView {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var navigationBarView: NavigationBar!
    @IBOutlet weak var deviceImageView: UIImageView!
    @IBOutlet weak var stripImageView: UIImageView!
    @IBOutlet weak var processingView: UIView!
    @IBOutlet weak var circleAnimateContainerView: CircleProgressView!
    @IBOutlet weak var processingLabel: UILabel!
    @IBOutlet weak var stripContainerView: UIView!
    @IBOutlet weak var manualGlucoseReadingButton: UIButton!
    @IBOutlet weak var manualButtonUnderlineView: UIView!
    
    // MARK: - Variables
    //====================================================
    var manualGlucoseButtonTapped: ((UIButton)->Void)?
    
    // MARK: - ViewLifeCycle
    //===============================
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    @IBAction func manualGlucoseReadingBtnTapped(_ sender: UIButton) {
        if let handler = self.manualGlucoseButtonTapped {
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
        setupNavigationBar()
        processingView.isHidden = true
        circleAnimateContainerView.trackBackgroundColor = .clear
        circleAnimateContainerView.backgroundColor = .clear
        circleAnimateContainerView.trackFillColor = AppColors.pinkishOrange
    }
    
    ///Navigation Bar setup
    func setupNavigationBar() {
        self.navigationBarView.stepNumberText = ""
    }
    
    ///Sets up text Title
    func setupText() {
        processingLabel.text = StringConstant.processing.value.uppercased()
        self.manualGlucoseReadingButton.setTitle(StringConstant.manualGlucoseEntry.value, for: .normal)
    }
    
    ///Font Setup
    func setupFonts() {
        processingLabel.font = AppFonts.Montserrat_SemiBold.withSize(18)
        manualGlucoseReadingButton.titleLabel?.font = AppFonts.Montserrat_Light.withSize(18)
    }
    
    ///Color setup
    func setupColors() {
        processingLabel.textColor = AppColors.pinkishOrange
        manualGlucoseReadingButton.setTitleColor(UIColor.init(light: .black, dark: .white), for: .normal)
        manualButtonUnderlineView.backgroundColor = UIColor.init(light: .black, dark: .white)
    }
    
    ///set progress for container view
    func animateCircle() {
        self.circleAnimateContainerView.setProgress(0.98, animated: true)
    }
}
