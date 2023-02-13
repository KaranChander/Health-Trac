//
//  ReadingView.swift
//   Health Track


import UIKit

class ReadingView: UIView {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var readingScrollView: UIScrollView!
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var nextImageWidth: NSLayoutConstraint!
    @IBOutlet weak var nextImageHeight: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextImage: UIImageView!
    
    // MARK: - Variables
    //====================================================
    var nextButtonTapped: ((UIButton) -> Void)?
    
    // MARK: - ViewLifeCycle
    //====================================================
    override func awakeFromNib() {
        initialStepup()

    }
    
    // MARK: - IBActions
    //====================================================
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if let handler = self.nextButtonTapped {
            handler(sender)
        }
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Initial setup of View
    func initialStepup() {
        setupFont()
        setupColor()
        setupNavigationBar()
        nextImageWidth.constant = 10
        readingScrollView.isScrollEnabled = false
    }
    
    ///Font setup
    func setupFont() {
        nextLabel.font = AppFonts.Montserrat_Regular.withSize(20)
    }
    
    ///Color setup
    func setupColor() {
        backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        nextLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        nextLabel.text = "Next"
        if #available(iOS 13.0, *) {
            nextImage.image = UIImage(named: "ic_next")
        } else {
            
        }
        nextImage.tintColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
    
    
    func setupNavigationBar() {
        self.navigationBar.stepNumberText = StringConstant.oneByFour.rawValue
    }
    
    func setupDoneButton() {
        nextLabel.font = AppFonts.Montserrat_Regular.withSize(20)
        nextLabel.textColor = UIColor(light: AppColors.pinkishOrange, dark: AppColors.pinkishOrange)
        nextLabel.text = "Done"
        if #available(iOS 13.0, *) {
            nextImage.image = UIImage(named: "ic_done_orange")
        } else {
            // Fallback on earlier versions
        }
        nextImage.tintColor = UIColor(light: AppColors.pinkishOrange, dark: AppColors.pinkishOrange)
        nextImageWidth.constant = 16
        nextImageHeight.constant = 13
    }
    
    func setupNextButton() {
        nextLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        nextLabel.text = "Next"
        if #available(iOS 13.0, *) {
            nextImage.image = UIImage(named: "ic_next")
        } else {
            // Fallback on earlier versions
        }
        nextImage.tintColor = UIColor(light: AppColors.black, dark: AppColors.white)
        nextImageWidth.constant = 10
        nextImageHeight.constant = 22
    }
}
