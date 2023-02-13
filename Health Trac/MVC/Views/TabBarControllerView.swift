//
//  TabBarControllerView.swift
//  Health Track


import Foundation
import UIKit


class TabBarView: UIView {
    
    // MARK: - IBOutlets
    //====================================================
    // Home Button
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var homeTitleLabel: UILabel!
    @IBOutlet weak var homeButtonView: UIButton!
    // Activity Button
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var activityButtonView: UIButton!
    
    // Expansion button
    @IBOutlet weak var middleExpandButtonView: UIButton!
    
    // Logbook Button
    @IBOutlet weak var logBookImageView: UIImageView!
    @IBOutlet weak var logBookLabel: UILabel!
    @IBOutlet weak var logBookButtonView: UIButton!
    // Settings Button
    @IBOutlet weak var settingsImageView: UIImageView!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsButtonView: UIButton!
    @IBOutlet weak var backgroundTabHazleView: UIView!
    // pop up view
    @IBOutlet weak var readingPopUpView: UIView!
    @IBOutlet weak var readingButtonView: UIButton!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var exerciseButtonView: UIButton!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var carbsButtonView: UIButton!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var tabBarScrollView: UIScrollView!
    
    // MARK: - Variables
    //===============================
    var middleBtnTapped: ((UIButton) -> Void)?
    var homeBtnTapped: ((UIButton) -> Void)?
    var activityBtnTapped: ((UIButton) -> Void)?
    var logbookBtnTapped: ((UIButton) -> Void)?
    var settingsBtnTapped: ((UIButton) -> Void)?
    var readingBtnTapped: ((UIButton) -> Void)?
    var exerciseBtnTapped: ((UIButton) -> Void)?
    var carbsBtnTapped: ((UIButton) -> Void)?
    var currentState: TabBarState = .home
    
    // MARK: - ViewLifeCycle
    //===============================
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        currentStateSetup()
    }
    
    func currentStateSetup() {
        switch self.currentState {
        case .home:
            self.tabBarScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        case .activity:
            self.tabBarScrollView.setContentOffset(CGPoint(x: self.tabBarScrollView.width, y: 0), animated: false)
            self.backgroundTabHazleView.transform = CGAffineTransform.init(translationX: self.width/5, y: 0)
            
            printDebug("==================================")
            printDebug(self.width)
            printDebug(self.width/5)
            printDebug(self.width/5 + self.width/10)
            printDebug("==================================")
            
            
        case .logbook:
            self.tabBarScrollView.setContentOffset(CGPoint(x: self.tabBarScrollView.width*2, y: 0), animated: false)
        case .settings:
            self.tabBarScrollView.setContentOffset(CGPoint(x: self.tabBarScrollView.width*3, y: 0), animated: false)
        }
    }
    
    // MARK: - IBActions
    //===============================
    @IBAction func middleButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.backgroundTabHazleView.transform = CGAffineTransform.init(translationX: self.middleExpandButtonView.globalFrame?.minX ?? 0, y: 0)
        }
        
        self.changeToDefaultColors(imageArray: [homeImageView, activityImageView, logBookImageView, settingsImageView], labelArray: [homeTitleLabel, activityLabel, logBookLabel, settingsLabel])
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            readingButtonView.transform = CGAffineTransform(translationX: 0, y: 100)
            exerciseButtonView.transform = CGAffineTransform(translationX: 0, y: 200)
            carbsButtonView.transform = CGAffineTransform(translationX: 0, y: 300)
            readingLabel.transform = CGAffineTransform(translationX: 0, y: 200)
            exerciseLabel.transform = CGAffineTransform(translationX: 0, y: 300)
            carbsLabel.transform = CGAffineTransform(translationX: 0, y: 400)
            
            UIView.animate(withDuration: 1.4,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 1,
                           options: .allowUserInteraction,
                           animations: { [weak self] in
                            self?.readingButtonView.transform = .identity
                            self?.exerciseButtonView.transform = .identity
                            self?.carbsButtonView.transform = .identity
                            
                            self?.carbsLabel.transform = .identity
                            self?.readingLabel.transform = .identity
                            self?.exerciseLabel.transform = .identity
                           },
                           completion: nil)
            UIView.animate(withDuration: 0.6, delay: 0, options: .transitionCrossDissolve, animations: {
                sender.transform = sender.transform.rotated(by: -5*(.pi / 4))    // 90˚

                self.readingPopUpView.isHidden = false
                self.readingPopUpView.alpha = 1
            }, completion: { _ in
            })
            
        } else {
            UIView.animate(withDuration: 0.6, delay: 0, options: .transitionCrossDissolve, animations: {
                sender.transform = sender.transform.rotated(by: 5*(.pi / 4))    // 90˚
                self.readingPopUpView.alpha = 0
                switch self.tabBarScrollView.contentOffset.x {
                case 0:
                    self.homeButtonTapped(self.homeButtonView)
                case self.tabBarScrollView.width:
                    self.activityButtonTapped(self.activityButtonView)
                case self.tabBarScrollView.width*2:
                    self.logBookButtonTapped(self.logBookButtonView)
                case self.tabBarScrollView.width*3:
                    self.settingsButtonTapped(self.settingsButtonView)
                default:
                    self.homeButtonTapped(self.homeButtonView)
                }
            }, completion: { _ in
                self.readingPopUpView.isHidden = true
            })
        }
        if let handler = self.middleBtnTapped {
            handler(sender)
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        self.tabBarScrollView.contentOffset.x = 0
        changeToDefaultColors(imageArray: [activityImageView, logBookImageView, settingsImageView], labelArray: [activityLabel, logBookLabel, settingsLabel])
        homeImageView.image = #imageLiteral(resourceName: "home_purple")
        homeTitleLabel.textColor = AppColors.heliotrope
        UIView.animate(withDuration: 0.5) {
            self.backgroundTabHazleView.transform = CGAffineTransform.init(translationX: self.homeButtonView.globalFrame?.minX ?? 0, y: 0)
        }
        if let handler = self.homeBtnTapped {
            handler(sender)
        }
    }
    
    
    @IBAction func activityButtonTapped(_ sender: UIButton) {
        self.tabBarScrollView.contentOffset.x = self.tabBarScrollView.width
        changeToDefaultColors(imageArray: [homeImageView, logBookImageView, settingsImageView], labelArray: [homeTitleLabel, logBookLabel, settingsLabel])
        activityImageView.image = #imageLiteral(resourceName: "activity_purple")
        activityLabel.textColor = AppColors.heliotrope
        
        UIView.animate(withDuration: 0.5) {
            self.backgroundTabHazleView.transform = CGAffineTransform.init(translationX: self.activityButtonView.globalFrame?.minX ?? 0, y: 0)
        }
        if let handler = self.activityBtnTapped {
            handler(sender)
        }
    }
    
    
    @IBAction func logBookButtonTapped(_ sender: UIButton) {
        self.tabBarScrollView.contentOffset.x = self.tabBarScrollView.width*2
        changeToDefaultColors(imageArray: [activityImageView, homeImageView, settingsImageView], labelArray: [activityLabel, homeTitleLabel, settingsLabel])
        logBookImageView.image = #imageLiteral(resourceName: "logbook_purple")
        logBookLabel.textColor = AppColors.heliotrope
        
        UIView.animate(withDuration: 0.5) {
            self.backgroundTabHazleView.transform = CGAffineTransform.init(translationX: self.logBookButtonView.globalFrame?.minX ?? 0, y: 0)
        }
        if let handler = self.logbookBtnTapped {
            handler(sender)
        }
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        self.tabBarScrollView.contentOffset.x = self.tabBarScrollView.width*3
        changeToDefaultColors(imageArray: [activityImageView, logBookImageView, homeImageView], labelArray: [activityLabel, logBookLabel, homeTitleLabel])
        settingsImageView.image = #imageLiteral(resourceName: "settings_purple")
        settingsLabel.textColor = AppColors.heliotrope
        
        UIView.animate(withDuration: 0.5) {
            self.backgroundTabHazleView.transform = CGAffineTransform.init(translationX: self.settingsButtonView.globalFrame?.minX ?? 0, y: 0)
        }
        if let handler = self.settingsBtnTapped {
            handler(sender)
        }
    }
    
    @IBAction func readingButtonTapped(_ sender: UIButton) {
        if let handler = self.readingBtnTapped {
            handler(sender)
        }
    }
    
    @IBAction func exerciseButtonTapped(_ sender: UIButton) {
        if let handler = self.exerciseBtnTapped {
            handler(sender)
        }
    }
    
    @IBAction func carbsButtonTapped(_ sender: UIButton) {
        if let handler = self.carbsBtnTapped {
            handler(sender)
        }
    }
    
    // MARK: - Functions
    //===============================
    
    ///Initial setup of View
    func initialSetup() {
        setupColors()
        setupImage()
        setupBorders()
        setupText()
        setupFonts()
        readingPopUpView.isHidden = true
        self.readingPopUpView.alpha = 0
    }
    
    ///Color setup
    func setupColors() {
        changeToDefaultColors(imageArray: [activityImageView, logBookImageView, settingsImageView], labelArray: [activityLabel, logBookLabel, settingsLabel])
        homeTitleLabel.textColor = AppColors.heliotrope
        self.middleExpandButtonView.backgroundColor = .clear
        readingLabel.textColor = AppColors.pinkishOrange
        exerciseLabel.textColor = AppColors.aquaMarine
        carbsLabel.textColor = AppColors.heliotrope
        readingButtonView.backgroundColor = AppColors.pinkishOrangeWithOpacity
        carbsButtonView.backgroundColor = AppColors.heliotropeWithOpacity
        exerciseButtonView.backgroundColor = AppColors.aquaMarineWithOpacity
    }
    
    ///Border Setup
    func setupBorders() {
        self.middleExpandButtonView.round()
        self.backgroundTabHazleView.round()
        self.readingButtonView.round()
        self.exerciseButtonView.round()
        self.carbsButtonView.round()
    }
    
    ///Font setup
    func setupFonts() {
        homeTitleLabel.font = AppFonts.Montserrat_Medium.withSize(12)
        activityLabel.font = AppFonts.Montserrat_Medium.withSize(12)
        logBookLabel.font = AppFonts.Montserrat_Medium.withSize(12)
        settingsLabel.font = AppFonts.Montserrat_Medium.withSize(12)
        readingLabel.font = AppFonts.Montserrat_SemiBold.withSize(15)
        carbsLabel.font = AppFonts.Montserrat_SemiBold.withSize(15)
        exerciseLabel.font = AppFonts.Montserrat_SemiBold.withSize(15)
    }
    
    ///Image Setup
    func setupImage() {
        homeImageView.image = #imageLiteral(resourceName: "home_purple")
        self.activityImageView.image = #imageLiteral(resourceName: "activity")
        self.logBookImageView.image = #imageLiteral(resourceName: "logbook")
        self.settingsImageView.image = #imageLiteral(resourceName: "settings")
        self.middleExpandButtonView.imageView?.contentMode = .scaleToFill
        self.middleExpandButtonView.setImage(#imageLiteral(resourceName: "ExpandCross"), for: .normal)
        self.readingButtonView.setImage(#imageLiteral(resourceName: "readings"), for: .normal)
        self.carbsButtonView.setImage(#imageLiteral(resourceName: "carbs"), for: .normal)
        self.exerciseButtonView.setImage(#imageLiteral(resourceName: "exercise"), for: .normal)
    }
    
    ///Function to handle default color
    func changeToDefaultColors(imageArray: [UIImageView], labelArray: [UILabel]) {
        for image in imageArray {
            switch image {
            case settingsImageView:
                self.settingsImageView.image = #imageLiteral(resourceName: "settings")
            case logBookImageView:
                self.logBookImageView.image = #imageLiteral(resourceName: "logbook")
            case activityImageView:
                self.activityImageView.image = #imageLiteral(resourceName: "activity")
            case homeImageView:
                self.homeImageView.image = #imageLiteral(resourceName: "home")
            default:
                break
            }
            image.tintColor = UIColor(light: .black, dark: .white)
        }
        for label in labelArray {
            label.textColor = UIColor(light: .black, dark: .white)
        }
    }
    
    ///Text Setup
    func setupText() {
        self.readingLabel.text = StringConstant.reading.value
        self.exerciseLabel.text = StringConstant.exercise.value
        self.carbsLabel.text = StringConstant.carbs.value
    }
}
