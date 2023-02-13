//
//  CarbsStepThreeView.swift
//   Health Track


import UIKit
import AVFoundation

class CarbsStepThreeView: UIView {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var shutterButton: UIButton!
    @IBOutlet weak var shutterButtonBaseView: UIView!
    @IBOutlet weak var previewLayerBaseView: UIView!
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var skipLabel: UILabel!
    @IBOutlet weak var skipImage: UIImageView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var cameraWarningBaseView: UIVisualEffectView!
    
    // MARK: - Variables
    //====================================================
    var previewLayer = AVCaptureVideoPreviewLayer()
    var skipBtnTapped: ((UIButton)->Void)?
    var getFilePath: ((String)->Void)?
    var imageCapture: (()->Void)?
    var showAlertBtnTapped: ((UIButton)->Void)?
    
    // MARK: - VIew Life Ccycle
    //====================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    // MARK: - IBActions
    //====================================================
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        if let handler = skipBtnTapped {
            handler(sender)
        }
    }
    
    @IBAction func showAlertButtonTapped(_ sender: UIButton) {
        if let handler = showAlertBtnTapped {
            handler(sender)
        }
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Initial setup of View
    func initialSetup() {
        setupFont()
        setupNavigationBar()
        previewLayerBaseView.layer.addSublayer(previewLayer)
        previewLayer.frame = previewLayerBaseView.frame
        previewLayer.backgroundColor = UIColor.clear.cgColor
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
        shutterButton.layer.cornerRadius = 35
        shutterButton.layer.borderColor = UIColor(light: AppColors.black, dark: AppColors.white).cgColor
        shutterButton.layer.borderWidth = 4
        shutterButtonBaseView.layer.cornerRadius = 27
        shutterButtonBaseView.backgroundColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
    
    ///Font setup
    func setupFont() {
        skipLabel.font = AppFonts.Montserrat_Regular.withSize(20)
    }
    
    ///Navigation Bar setup
    func setupNavigationBar() {
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.stepNumberText = StringConstant.threeByFive.rawValue
    }
    
    func showWarnigView() {
        self.cameraWarningBaseView.isHidden = false
    }
    
    ///Handling didTap on take Photo
    @objc private func didTapTakePhoto() {
        if let handler = imageCapture {
            handler()
        }
    }
}



