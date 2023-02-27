//
//  HomeControllerView.swift
//   Health Track


import UIKit
import CHIPageControl

class HomeControllerView: UIView {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var homeReadCollectionView: UICollectionView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusDescriptionLabel: UILabel!
    @IBOutlet weak var pageControl: CHIPageControlJalapeno!
    @IBOutlet weak var timeArrow: UIImageView!
    @IBOutlet weak var calendarTopBlurView: UIVisualEffectView!
    @IBOutlet weak var timeStackView: UIStackView!
    @IBOutlet weak var glucoseTypeLabel: UILabel!
    @IBOutlet weak var hazeImageView: UIImageView!
    
    // MARK: - Variables
    //===============================
    var calendarBtnTapped: ((UIButton) -> Void)?
    var timeHeaderBtnTapped: ((UIButton) -> Void)?
    var currentPage: Int = 0 {
        didSet {
            pageControl.set(progress: currentPage, animated: true)
        }
    }
    var pageSize: CGSize {
        let layout = self.homeReadCollectionView.collectionViewLayout as! CarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    // MARK: - ViewLifeCycle
    //===============================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    // MARK: - IBActions
    //===============================
    @IBAction func calendarButtonTapped(_ sender: UIButton) {
        if let handler = self.calendarBtnTapped {
            handler(sender)
        }
    }
    
    @IBAction func timeHeaderButtonTapped(_ sender: UIButton) {
        if let handler = self.timeHeaderBtnTapped {
            handler(sender)
        }
    }
    
    
    // MARK: - Functions
    //===============================
    
    ///Initial Setup of View
    func initialSetup() {
        self.setupFont()
        self.setupColor()
        self.calendarTopBlurView.isHidden = true
        homeReadCollectionView.register(UINib(nibName: "HomeReadCell", bundle: nil), forCellWithReuseIdentifier: "HomeReadCell")
        let carouselFlowLayout = CarouselFlowLayout()
        carouselFlowLayout.itemSize = CGSize(width: self.frame.width/2 + 80, height: homeReadCollectionView.height)
        carouselFlowLayout.scrollDirection = .horizontal
        carouselFlowLayout.sideItemScale = 0.7
        carouselFlowLayout.sideItemAlpha = 0.3
        carouselFlowLayout.spacingMode = .fixed(spacing: -48)
        homeReadCollectionView.collectionViewLayout = carouselFlowLayout
        pageControl.layer.cornerRadius = pageControl.frame.height/2
        pageControl.numberOfPages = 1
//        pageControl.PageControlBorderWidth = 1
        pageControl.radius = 6
        pageControl.inactiveTransparency = 0
        pageControl.padding = 17
    }
    
    ///Font Setup
    func setupFont() {
        dayLabel.font = AppFonts.Montserrat_Light.withSize(21)
        dateLabel.font = AppFonts.Montserrat_Medium.withSize(28)
        statusLabel.font = AppFonts.Montserrat_Medium.withSize(27)
        glucoseTypeLabel.font = AppFonts.Montserrat_Medium.withSize(17)
        statusDescriptionLabel.font = AppFonts.Montserrat_Light.withSize(17)
        dayLabel.addCharacterSpacing(of: 0.0)
        dateLabel.addCharacterSpacing(of: 0.5)
        statusDescriptionLabel.addCharacterSpacing(of: 0.0)
        statusDescriptionLabel.textAlignment = .center
        timeLabel.setUpTimeString(text: timeLabel.text ?? "", baselineOffset: 8, baseSize: 22, superScript: 12, font: .Montserrat_Light)
    }
    
    ///Color Setup
    func setupColor() {
        self.backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        dayLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        dateLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        timeLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        statusLabel.textColor = AppColors.aquaMarine
        statusDescriptionLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        timeArrow.tintColor = UIColor(light: AppColors.black, dark: AppColors.white)
        pageControl.backgroundColor = UIColor(light: AppColors.lightGray, dark: AppColors.darkGray).withAlphaComponent(0.2)
        pageControl.tintColor = UIColor(light: AppColors.black, dark: AppColors.white)
        pageControl.currentPageTintColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
    
    ///Setting up header text
    func setupHeaderText(date: Date = Date().localDate(), time: String = "") {
        self.dateLabel.text = date.convertToFormattedString()
        self.dayLabel.text = date.timeAgoSince
        if !time.isEmpty {
        timeLabel.setUpTimeString(text: time, baselineOffset: 8, baseSize: 22, superScript: 12, font: .Montserrat_Light)
        }
    }
    
    ///Updates Collection View Values
    func updateCollectionViewValues() {
        homeReadCollectionView.reloadData()
    }
    
    func setupStatusLabel(status: String, readingType: String) {
        self.statusLabel.text = status.uppercased()
        updateGlucoseTypeLabel(index: pageControl.currentPage)
        if status == glucoseLevel.low.rawValue {
            self.statusDescriptionLabel.text = glucoseLevelDescription.low.rawValue
            self.statusLabel.textColor = AppColors.pinkishOrange
            self.hazeImageView.image = UIImage(named: "eclipsePinkishOrange")
        } else if status == glucoseLevel.high.rawValue {
            self.statusDescriptionLabel.text = glucoseLevelDescription.high.rawValue
            self.statusLabel.textColor = AppColors.highRed
            self.hazeImageView.image = UIImage(named: "eclipseRed")
        } else {
            self.statusDescriptionLabel.text = glucoseLevelDescription.normal.rawValue
            self.statusLabel.textColor = AppColors.aquaMarine
            self.hazeImageView.image = UIImage(named: "ellipse367")
        }
    }
    
    func updateGlucoseTypeLabel(index: Int) {
        glucoseTypeLabel.fadeTransition(0.4)
//        if index < 2 {
            glucoseTypeLabel.text = glucoseReadingsType.blood.rawValue
//        } else {
//            glucoseTypeLabel.text = glucoseReadingsType.saliva.rawValue
//        }
    }
}

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
