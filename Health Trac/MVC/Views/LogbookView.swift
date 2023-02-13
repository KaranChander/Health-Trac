//
//  LogbookView.swift
//   Health Track


import UIKit

enum LogbookSegmentState {
    case days
    case weeks
    case months
    case years
}

class LogbookView: UIView {
    
    // MARK: - IBOutlets
    //========================================================
    @IBOutlet weak var calenderButton: UIButton!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headerBlurView: UIVisualEffectView!
    @IBOutlet weak var timeSeparationHeader: UIView!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var backgroundHazleView: UIView!
    @IBOutlet weak var scrollBackgroundView: UIView!
    @IBOutlet weak var logbookScrollView: UIScrollView!
    // Card views
    @IBOutlet weak var graphStackView: UIStackView!
    
    @IBOutlet weak var glucoseContainerView: UIView!
    @IBOutlet weak var exerciseContainerView: UIView!
    @IBOutlet weak var carbsContainerView: UIView!
    @IBOutlet weak var glucoseTitleLabel: UILabel!
    @IBOutlet weak var readingsLabel: UILabel!
    @IBOutlet weak var exerciseTitleLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var carbsTitleLabel: UILabel!
    @IBOutlet weak var gramsLabel: UILabel!
    @IBOutlet weak var glucoseUpperDottedLine: UIView!
    
    @IBOutlet weak var glucoseBottmDottedLine: UIView!
    
    @IBOutlet weak var exerciseDottedLine: UIView!
    @IBOutlet weak var carbsDottedLine: UIView!
    @IBOutlet weak var glucoseDataBackgroundView: UIView!
    
    // Carbs card
    @IBOutlet weak var carbsFirstView: UIView!
    @IBOutlet weak var carbsDataBackgroundView: UIView!
    @IBOutlet weak var carbsSecondView: UIView!
    
    // Exercise card
    @IBOutlet weak var exerciseFirstView: UIView!
    @IBOutlet weak var exerciseDataBackgroundView: UIView!
    @IBOutlet weak var exerciseSecondView: UIView!
    
    @IBOutlet weak var detailCardContainerView: UIView!
    
    // constraints to resize the screen
    @IBOutlet weak var upperConstranitConstant: NSLayoutConstraint!
    @IBOutlet weak var lowerConstraintConstant: NSLayoutConstraint!
    
    @IBOutlet weak var glucoseButtonOneView: UIView!
    @IBOutlet weak var glucoseButtonTwoView: UIView!
    @IBOutlet weak var glucoseButtonThreeView: UIView!
    @IBOutlet weak var glucoseButtonOne: UIButton!
    @IBOutlet weak var glucoseButtonTwo: UIButton!
    @IBOutlet weak var glucoseButtonThree: UIButton!
    
    @IBOutlet weak var rightOverlayImageView: UIImageView!
    @IBOutlet weak var leftOverlayImageView: UIImageView!
    
    @IBOutlet weak var glucoseGraphView: UIView!
    @IBOutlet weak var glucoseGraphImage: UIImageView!
    @IBOutlet weak var exerciseGraphView: UIView!
    @IBOutlet weak var exerciseGraphImage: UIImageView!
    @IBOutlet weak var carbsGraphView: UIView!
    @IBOutlet weak var carbsGraphImage: UIImageView!
    
    @IBOutlet weak var glucoseDayView: UIView!
    @IBOutlet weak var exerciseDayView: UIView!
    @IBOutlet weak var carbsDayView: UIView!
    
    @IBOutlet weak var glucoseConstraint: NSLayoutConstraint!
    @IBOutlet weak var glucoseWeekUpperDottedLine: UIView!
    @IBOutlet weak var glucoseWeekLowerDottedLine: UIView!
    @IBOutlet weak var exerciseWeekDottedLine: UIView!
    @IBOutlet weak var carbsWeekDottedLine: UIView!
    
    @IBOutlet weak var scrollViewWidthConstraint: NSLayoutConstraint!
    
    var color: UIColor = .white
    var segmentState: LogbookSegmentState = .days
    let rightGradient = CAGradientLayer()
    let gradient = CAGradientLayer()
    var buttonStatus: Bool = false
    
    // MARK: - Properties
    //===============================
    var calenderBtnTapped: ((UIButton) -> Void)?
    var exerciseFirstBtnTapped: ((UIButton) -> Void)?
    var exerciseSecondBtnTapped: ((UIButton) -> Void)?
    var carbsFirstBtnTapped: ((UIButton) -> Void)?
    var carbsSecondBtnTapped: ((UIButton) -> Void)?
    var glucoseFirstBtnTapped: ((UIButton) -> Void)?
    var glucoseSecondBtnTapped: ((UIButton) -> Void)?
    var glucoseThirdBtnTapped: ((UIButton) -> Void)?
    weak var shapeLayer: CAShapeLayer?
    var graphViewArray: [GraphTimeSeparatorView] = []
    var logbookDetailDataView = LogbookDetailDataView.instanceFromNib()
    var arr = ["12am", "3am", "6am", "9am", "12pm", "3pm", "6pm", "9pm"]
    
    // MARK: - ViewLifeCycle
    //===============================
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
        if checkIsIphoneXOrGreater() {
            upperConstranitConstant.constant = 29
            lowerConstraintConstant.constant = 30
        } else {
            upperConstranitConstant.constant = 0
            lowerConstraintConstant.constant = 10
        }
    }
    
    // MARK: - IBActions
    //===============================
    @IBAction func calenderButtonTapped(_ sender: UIButton) {
        if let handler = self.calenderBtnTapped {
            handler(sender)
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func dayButtonTapped(_ sender: UIButton) {
        scrollViewWidthConstraint.constant = 640
        if self.segmentState != .days {
            segmentState = .days
            for views in graphViewArray {
                views.removeFromSuperview()
            }
            self.arr = ["12am", "3am", "6am", "9am", "12pm", "3pm", "6pm", "9pm"]
            graphViewArray = []
            instantionGraphViews()
            self.setupGraphImages(visible: false)
            glucoseButtonOne.isHidden = buttonStatus
            glucoseButtonTwo.isHidden = buttonStatus
            glucoseButtonThree.isHidden = buttonStatus
            self.layoutIfNeeded()
            UIView.animate(withDuration: 0.5) {
                self.backgroundHazleView.transform = CGAffineTransform.init(translationX: self.dayButton.frame.minX + 2, y: 0)
                var index = 0
                while index < self.arr.count {
                    self.setupScrollBackgroundView(atIndex: index)
                    index+=1
                }
            }
        }
    }
    
    @IBAction func weekButtonTapped(_ sender: UIButton) {
        scrollViewWidthConstraint.constant = 560
        if segmentState != .weeks {
            glucoseGraphImage.image = UIImage(named: "weekGlucose")
            exerciseGraphImage.image = UIImage(named: "weekExercise")
            carbsGraphImage.image = UIImage(named: "weekCarbs")
            segmentState = .weeks
            for views in graphViewArray {
                views.removeFromSuperview()
            }
            self.arr = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            graphViewArray = []
            instantionGraphViews()
            self.setupGraphImages(visible: true)
            self.layoutIfNeeded()
            UIView.animate(withDuration: 0.5) {
                self.backgroundHazleView.transform = CGAffineTransform.init(translationX: self.weekButton.frame.minX, y: 0)
                var index = 0
                while index < self.arr.count {
                    self.setupScrollBackgroundView(atIndex: index)
                    index+=1
                }
            }
        }
    }
    
    @IBAction func monthButtonTapped(_ sender: UIButton) {
        scrollViewWidthConstraint.constant = 960
        if segmentState != .months {
            glucoseGraphImage.image = UIImage(named: "monthGlucose")
            exerciseGraphImage.image = UIImage(named: "monthExercise")
            carbsGraphImage.image = UIImage(named: "monthCarbs")
            segmentState = .months
            for views in graphViewArray {
                views.removeFromSuperview()
            }
            self.arr = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            graphViewArray = []
            instantionGraphViews()
            self.setupGraphImages(visible: true)
            self.layoutIfNeeded()
            UIView.animate(withDuration: 0.5) {
                self.backgroundHazleView.transform = CGAffineTransform.init(translationX: self.monthButton.frame.minX, y: 0)
                var index = 0
                while index < self.arr.count {
                    self.setupScrollBackgroundView(atIndex: index)
                    index+=1
                }
            }
        }
    }
    
    @IBAction func yearButtonTapped(_ sender: UIButton) {
        scrollViewWidthConstraint.constant = 720
        if segmentState != .years {
            glucoseGraphImage.image = UIImage(named: "yearGlucose")
            exerciseGraphImage.image = UIImage(named: "yearExercise")
            carbsGraphImage.image = UIImage(named: "yearCarbs")
            segmentState = .years
            for views in graphViewArray {
                views.removeFromSuperview()
            }
            self.arr = ["2021", "2022"]
            graphViewArray = []
            instantionGraphViews()
            self.setupGraphImages(visible: true)
            self.layoutIfNeeded()
            UIView.animate(withDuration: 0.5) {
                self.backgroundHazleView.transform = CGAffineTransform.init(translationX: self.yearButton.frame.minX - 2, y: 0)
                var index = 0
                while index < self.arr.count {
                    self.setupScrollBackgroundView(atIndex: index)
                    index+=1
                }
            }
            
        }
        
    }
    
    @IBAction func glucoseFirstDataButton(_ sender: UIButton) {
        if let handler = self.glucoseFirstBtnTapped {
            handler(sender)
        }
    }
    @IBAction func glucoseSecondDataButton(_ sender: UIButton) {
        if let handler = self.glucoseSecondBtnTapped {
            handler(sender)
        }
    }
    @IBAction func glucoseThirdDataButton(_ sender: UIButton) {
        if let handler = self.glucoseThirdBtnTapped {
            handler(sender)
        }
    }
    
    @IBAction func exerciseFirstDataButtonTapped(_ sender: UIButton) {
        if let handler = self.exerciseFirstBtnTapped {
            handler(sender)
        }
    }
    
    
    @IBAction func exerciseSecondDataButtonTapped(_ sender: UIButton) {
        if let handler = self.exerciseSecondBtnTapped {
            handler(sender)
        }
    }
    
    
    @IBAction func carbsFirstDataButtonTapped(_ sender: UIButton) {
        if let handler = self.carbsFirstBtnTapped {
            handler(sender)
        }
    }
    
    @IBAction func carbsSecondButtonTapped(_ sender: UIButton) {
        if let handler = self.carbsSecondBtnTapped {
            handler(sender)
        }
    }
    
    
    // MARK: - Functions
    //========================================================
    
    ///Initial setup of Views
    func initialSetup() {
        setupFont()
        setupColor()
        setupHeaderText()
        setupText()
        setupGlucoseContainer()
        setupExerciseContainer()
        setupCarbsContainer()
        instantionGraphViews()
        UIView.animate(withDuration: 0.5) {
            self.backgroundHazleView.transform = CGAffineTransform.init(translationX: self.monthButton.frame.minX, y: 0)
            var index = 0
            while index < self.arr.count {
                self.setupScrollBackgroundView(atIndex: index)
                index+=1
            }
        }
        headerBlurView.isHidden = true
        backgroundHazleView.cornerRadius = 14
        backgroundHazleView.backgroundColor = UIColor.init(light: #colorLiteral(red: 0.8098876397, green: 0.8195291592, blue: 0.8195291592, alpha: 1), dark: #colorLiteral(red: 0.3019241393, green: 0.3019818664, blue: 0.3019204736, alpha: 1))
        UIView.animate(withDuration: 0.5) {
            self.backgroundHazleView.transform = CGAffineTransform.init(translationX: self.dayButton.frame.minX + 2, y: 0)
        }
        detailCardContainerView.round(radius: 7)
        detailCardContainerView.isHidden = true
        detailCardContainerView.alpha = 0
    }
    
    ///Instantiating Graph Views
    func instantionGraphViews() {
        var i = 0
        while i < arr.count {
            graphViewArray.append(GraphTimeSeparatorView.instanceFromNib())
            i+=1
        }
    }
    
    ///Setting up scroll View
    func setupScrollBackgroundView(atIndex: Int) {
        var distance:CGFloat = 0
        if self.segmentState == .weeks {
            distance = scrollViewWidthConstraint.constant / 7
        } else if segmentState == .days {
            distance = scrollViewWidthConstraint.constant / 8
        } else if segmentState == .months {
            distance = scrollViewWidthConstraint.constant / 12
        } else if segmentState == .years {
            distance = scrollViewWidthConstraint.constant / 2
        }
        let verticalLineView = graphViewArray[atIndex]
        verticalLineView.frame = CGRect.init(x: distance * (CGFloat(atIndex)), y: 0, width: verticalLineView.width, height: scrollBackgroundView.height)
        verticalLineView.timeLabel.text = arr[atIndex]
        verticalLineView.topTimeLabel.text = arr[atIndex]
        scrollBackgroundView.insertSubview(verticalLineView, at: 0)
    }
    
    ///Font Setup
    func setupFont() {
        dayLabel.font = AppFonts.Montserrat_Light.withSize(21)
        dateLabel.font = AppFonts.Montserrat_Medium.withSize(28)
        dayLabel.addCharacterSpacing(of: -0.5)
        dateLabel.addCharacterSpacing(of: -0.59)
        dayButton.titleLabel?.font = AppFonts.Montserrat_Regular.withSize(15)
        weekButton.titleLabel?.font = AppFonts.Montserrat_Regular.withSize(15)
        monthButton.titleLabel?.font = AppFonts.Montserrat_Regular.withSize(15)
        yearButton.titleLabel?.font = AppFonts.Montserrat_Regular.withSize(15)
    }
    
    ///Setup Glucose Container
    func setupGlucoseContainer() {
        glucoseContainerView.backgroundColor = #colorLiteral(red: 1, green: 0.445323027, blue: 0.2866085677, alpha: 0.3014003208)
        glucoseTitleLabel.text = StringConstant.glucose.value
        glucoseTitleLabel.textColor = AppColors.pinkishOrange
        glucoseTitleLabel.font = AppFonts.Montserrat_Semibold.withSize(16)
        readingsLabel.text = StringConstant.readings.value.capitalizedFirst
        readingsLabel.textColor = UIColor.init(light: .black, dark: .white)
        readingsLabel.font = AppFonts.Montserrat_Light.withSize(12)
        glucoseUpperDottedLine.addDashedBorder(color: AppColors.pinkishOrange)
        glucoseBottmDottedLine.addDashedBorder(color: AppColors.pinkishOrange)
        glucoseWeekUpperDottedLine.backgroundColor = AppColors.clear
        glucoseWeekUpperDottedLine.addDashedBorder(color: AppColors.pinkishOrange)
        glucoseWeekLowerDottedLine.backgroundColor = AppColors.clear
        glucoseWeekLowerDottedLine.addDashedBorder(color: AppColors.pinkishOrange)
        
    }
    
    ///Setup Exercise Container
    func setupExerciseContainer() {
        exerciseContainerView.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.831372549, blue: 0.8470588235, alpha: 0.3031666036)
        exerciseTitleLabel.text = StringConstant.exercise.value
        exerciseTitleLabel.textColor = AppColors.aquaMarine
        exerciseTitleLabel.font = AppFonts.Montserrat_Semibold.withSize(16)
        minutesLabel.text = StringConstant.minutes.value
        minutesLabel.textColor = UIColor.init(light: .black, dark: .white)
        minutesLabel.font = AppFonts.Montserrat_Light.withSize(12)
        exerciseDottedLine.addDashedBorder(color: AppColors.aquaMarine)
        exerciseWeekDottedLine.backgroundColor = .clear
        exerciseWeekDottedLine.addDashedBorder(color: AppColors.green)
        exerciseFirstView.clipsToBounds = true
        exerciseFirstView.layer.cornerRadius = 5
        exerciseFirstView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    ///Setup Carbs Container
    func setupCarbsContainer() {
        carbsContainerView.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0.3450980392, blue: 0.9333333333, alpha: 0.3042008796)
        carbsTitleLabel.text = StringConstant.carbohydrates.value
        carbsTitleLabel.textColor = AppColors.heliotrope
        carbsTitleLabel.font = AppFonts.Montserrat_Semibold.withSize(16)
        gramsLabel.text = StringConstant.grams.value
        gramsLabel.textColor = UIColor.init(light: .black, dark: .white)
        gramsLabel.font = AppFonts.Montserrat_Light.withSize(12)
        carbsDottedLine.addDashedBorder(color: AppColors.heliotrope)
        carbsWeekDottedLine.backgroundColor = .clear
        carbsWeekDottedLine.addDashedBorder(color: AppColors.heliotrope)
        carbsFirstView.clipsToBounds = true
        carbsFirstView.layer.cornerRadius = 5
        carbsFirstView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    ///Color Setup
    func setupColor() {
        self.color = UIColor(light: .white, dark: .black)
        
        rightOverlayImageView.tintColor = UIColor(light: AppColors.white, dark: AppColors.black)
        leftOverlayImageView.tintColor = UIColor(light: AppColors.white, dark: AppColors.black)
        self.backgroundColor = UIColor(light: AppColors.white, dark: AppColors.black)
        dayLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        dateLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        timeSeparationHeader.backgroundColor = .clear
        timeSeparationHeader.cornerRadius = 18
        timeSeparationHeader.setBorder(width: 2, color: UIColor(light: .black, dark: .white))
        
        dayButton.setTitleColor(UIColor(light: AppColors.black, dark: AppColors.white), for: .normal)
        weekButton.setTitleColor(UIColor(light: AppColors.black, dark: AppColors.white), for: .normal)
        monthButton.setTitleColor(UIColor(light: AppColors.black, dark: AppColors.white), for: .normal)
        yearButton.setTitleColor(UIColor(light: AppColors.black, dark: AppColors.white), for: .normal)
        
        //ButtonView
        glucoseButtonOneView.cornerRadius = glucoseButtonOneView.frame.height/2
        glucoseButtonOneView.backgroundColor = AppColors.pinkishOrange.withAlphaComponent(0.5)
        
        glucoseButtonTwoView.cornerRadius = glucoseButtonTwoView.frame.height/2
        glucoseButtonTwoView.backgroundColor = AppColors.pinkishOrange.withAlphaComponent(0.5)
        
        glucoseButtonThreeView.cornerRadius = glucoseButtonThreeView.frame.height/2
        glucoseButtonThreeView.backgroundColor = AppColors.pinkishOrange.withAlphaComponent(0.5)
        
        glucoseButtonOne.backgroundColor = .clear
        glucoseButtonOne.cornerRadius = glucoseButtonOne.frame.height/2
        
    }
    
    /// Sets up Header Text
    func setupHeaderText(date: Date = Date()) {
        self.dateLabel.text = date.convertToFormattedString()
        self.dayLabel.text = date.timeAgoSince
    }
    
    ///Setting up Button Segment Controller Text
    func setupText() {
        dayButton.setTitle("D", for: .normal)
        weekButton.setTitle("W", for: .normal)
        monthButton.setTitle("M", for: .normal)
        yearButton.setTitle("Y", for: .normal)
    }
    
    ///Handling Animation of Details View
    func animateSlidingLinkView(dataView: UIView){
        
        // remove old shape layer if any
        
        self.shapeLayer?.removeFromSuperlayer()
        
        // create whatever path you want
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: ((dataView.globalFrame!.minX + dataView.globalFrame!.maxX)/2 ), y: dataView.globalFrame?.minY ?? 0))
        path.addLine(to: CGPoint(x: ((dataView.globalFrame!.minX + dataView.globalFrame!.maxX)/2 ), y: detailCardContainerView.globalFrame?.maxY ?? 0))
        
        // create shape layer for that path
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor(light: AppColors.black, dark: AppColors.white).cgColor
        shapeLayer.strokeColor = UIColor(light: AppColors.black, dark: AppColors.white).cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.path = path.cgPath
        
        self.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 0
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        self.shapeLayer = shapeLayer
    }
    
    ///Hides Container View
    func hideContainerView(container: UIView, status: Bool) {
        if container == self.glucoseContainerView {
            buttonStatus = status
            glucoseDataBackgroundView.isHidden = status
            self.glucoseButtonOne.isHidden = status
            self.glucoseButtonTwo.isHidden = status
            self.glucoseButtonThree.isHidden = status
        } else if container == self.exerciseContainerView {
            self.exerciseDataBackgroundView.isHidden = status
        } else if container == self.carbsContainerView {
            self.carbsDataBackgroundView.isHidden = status
        }
        if segmentState != LogbookSegmentState.days {
            setupGraphImages(visible: true)
        }
    }
    
    ///Sets up Container view
    func setupDetailView(reading: ReadingsDetail) {
        if reading.readingType == ReadingsType.glucose.rawValue {
            self.logbookDetailDataView.sideView.backgroundColor = AppColors.brightPinkishOrange
            self.logbookDetailDataView.backgroundColor = AppColors.brightPinkishOrange.withAlphaComponent(0.3)
            self.logbookDetailDataView.headLabel.text = "\(reading.glucoseReadingType.capitalizedFirst) Reading"
            self.logbookDetailDataView.headLabel.textColor = AppColors.brightPinkishOrange
            self.logbookDetailDataView.timeLabel.textColor = AppColors.brightPinkishOrange
            let createdTime = reading.createdAt.split(separator: "-")
            self.logbookDetailDataView.timeLabel.text = "\(createdTime[1])"
            let value = NSAttributedString(string: "\(reading.glucoseReading)",
                                           attributes: [
                                            .font: AppFonts.Montserrat_Regular.withSize(20)
                                           ])
            let spacing = NSAttributedString(string: " ",
                                             attributes: [
                                                .font: AppFonts.Montserrat_Regular.withSize(20)
                                             ])
            let unit = NSAttributedString(string: reading.glucoseUnit,
                                          attributes: [
                                            .font: AppFonts.Montserrat_Regular.withSize(8)
                                          ])
            let attributedString = NSMutableAttributedString()
            attributedString.append(value)
            attributedString.append(spacing)
            attributedString.append(unit)
            self.logbookDetailDataView.readingLabel.attributedText = attributedString
            self.logbookDetailDataView.statusLabel.text = reading.readingLevel.uppercased()
        } else if reading.readingType == ReadingsType.exercise.rawValue {
            self.logbookDetailDataView.sideView.backgroundColor = AppColors.aquaMarine
            self.logbookDetailDataView.backgroundColor = AppColors.aquaMarine.withAlphaComponent(0.3)
            self.logbookDetailDataView.headLabel.text = reading.readingType.capitalizedFirst
            self.logbookDetailDataView.headLabel.textColor = AppColors.aquaMarine
            self.logbookDetailDataView.timeLabel.textColor = AppColors.aquaMarine
            let createdTime = reading.createdAt.split(separator: "-")
            self.logbookDetailDataView.timeLabel.text = "\(createdTime[1])"
            let attributedString = NSMutableAttributedString()
            let spacing = NSAttributedString(string: " ",
                                             attributes: [
                                                .font: AppFonts.Montserrat_Regular.withSize(20)
                                             ])
            if reading.exerciseReading?.hours ?? 0 > 0 {
                let hour = NSAttributedString(string: "\(reading.exerciseReading?.hours ?? 0)", attributes: [
                    .font: AppFonts.Montserrat_Regular.withSize(20)
                ])
                let hourUnit = NSAttributedString(string: StringConstant.hours.value.capitalizedFirst,
                                                  attributes: [
                                                    .font: AppFonts.Montserrat_Regular.withSize(8)
                                                  ])
                attributedString.append(hour)
                attributedString.append(spacing)
                attributedString.append(hourUnit)
                attributedString.append(spacing)
            }
            let minutes = NSAttributedString(string: "\(reading.exerciseReading?.minutes ?? 0)",
                                             attributes: [
                                                .font: AppFonts.Montserrat_Regular.withSize(20)
                                             ])
            let minUnit = NSAttributedString(string: StringConstant.minutes.value.capitalizedFirst,
                                             attributes: [
                                                .font: AppFonts.Montserrat_Regular.withSize(8)
                                             ])
            attributedString.append(minutes)
            attributedString.append(spacing)
            attributedString.append(minUnit)
            self.logbookDetailDataView.readingLabel.attributedText = attributedString
            self.logbookDetailDataView.statusLabel.text = ""
//            self.logbookDetailDataView.statusLabel.text = reading.userDescription
        } else if reading.readingType == ReadingsType.carbs.rawValue {
            self.logbookDetailDataView.sideView.backgroundColor = AppColors.heliotrope
            self.logbookDetailDataView.backgroundColor = AppColors.heliotrope.withAlphaComponent(0.3)
            self.logbookDetailDataView.headLabel.text = reading.readingType.capitalizedFirst
            self.logbookDetailDataView.headLabel.textColor = AppColors.heliotrope
            self.logbookDetailDataView.timeLabel.textColor = AppColors.heliotrope
            let createdTime = reading.createdAt.split(separator: "-")
            self.logbookDetailDataView.timeLabel.text = "\(createdTime[1])"
            let value = NSAttributedString(string: reading.carbsReading,
                                           attributes: [
                                            .font: AppFonts.Montserrat_Regular.withSize(20)
                                           ])
            let spacing = NSAttributedString(string: " ",
                                             attributes: [
                                                .font: AppFonts.Montserrat_Regular.withSize(20)
                                             ])
            let unit = NSAttributedString(string: StringConstant.grams.value,
                                          attributes: [
                                            .font: AppFonts.Montserrat_Regular.withSize(8)
                                          ])
            let attributedString = NSMutableAttributedString()
            attributedString.append(value)
            attributedString.append(spacing)
            attributedString.append(unit)
            self.logbookDetailDataView.readingLabel.attributedText = attributedString
//            self.logbookDetailDataView.statusLabel.text = reading.userDescription
            self.logbookDetailDataView.statusLabel.text = ""
        }
    }
    
}

//MARK: - TraitCollection Extention
extension LogbookView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        initialSetup()
    }
    
    ///Sets up graph images
    func setupGraphImages(visible: Bool) {
        
        glucoseDayView.isHidden = visible
        exerciseDayView.isHidden = visible
        carbsDayView.isHidden = visible
        exerciseDottedLine.isHidden = visible
        
        carbsDottedLine.isHidden = visible
        
        glucoseButtonOne.isHidden = visible
        glucoseButtonTwo.isHidden = visible
        glucoseButtonThree.isHidden = visible
        glucoseGraphView.isHidden = !visible
        exerciseGraphView.isHidden = !visible
        carbsGraphView.isHidden = !visible
    }
    
    ///Handles behaviour of dashed lines in graph
    func updatePath() {
        DispatchQueue.main.async {
            self.glucoseWeekUpperDottedLine.backgroundColor = AppColors.clear
            self.glucoseWeekUpperDottedLine.addDashedBorder(color: AppColors.pinkishOrange)
            self.glucoseWeekLowerDottedLine.backgroundColor = AppColors.clear
            self.glucoseWeekLowerDottedLine.addDashedBorder(color: AppColors.pinkishOrange)
            
            self.exerciseWeekDottedLine.backgroundColor = .clear
            self.exerciseWeekDottedLine.addDashedBorder(color: AppColors.aquaMarine)
            
            self.carbsWeekDottedLine.backgroundColor = .clear
            self.carbsWeekDottedLine.addDashedBorder(color: AppColors.heliotrope)
        }
    }
}
