//
//  LogbookViewController.swift
//   Health Track


import UIKit
import FSCalendar

class LogbookViewController: UIViewController {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var logbookView: LogbookView!
    
    // MARK: - Properties
    //====================================================
    var calenderView = CustomCalender.instanceFromNib()
    var readingsArray = [ReadingsDetail]()
    var sections: [(date: Date, items: [ReadingsDetail])] = []
    var currentCalendarDate = Date()
    var readingModelArray = [ReadingsModel]()
    var latestGlucoseReadings = [ReadingsDetail]()
    var latestExerciseReadings = [ReadingsDetail]()
    var latestCarbsReadings = [ReadingsDetail]()
    var currentAnimationButton: UIButton?
    var animator = UIViewPropertyAnimator()
    var dateSet: Set<String> = []
    
    // MARK: - Lifecycle Methods
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidLayoutSubviews() {
        logbookView.updatePath()
    }
    
    ///Initial setup of VC
    func initialSetup() {
        getReadingsData()
        calenderView.customCalenderView.delegate = self
        calenderView.customCalenderView.dataSource = self
        setupLogbookDetailCardView()
        setupSelectedWeekday(date: Date().localDate())
        self.logbookView.logbookScrollView.delegate = self
        self.actions()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        logbookView.scrollBackgroundView.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLogbook), name: NSNotification.Name(StringConstant.updateLogBook.value), object: nil)
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        hideDetailsView(button: currentAnimationButton ?? UIButton())
    }
    
    ///Handles IBActions from View
    func actions() {
        
        //Handling Calender Button Tap
        self.logbookView.calenderBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            if self.logbookView.headerBlurView.isHidden == true {
                self.logbookView.headerBlurView.isHidden = false
                self.calenderView.frame = CGRect(x: 0, y: 120, width: self.logbookView.width, height: self.logbookView.height)
                self.calenderView.customCalenderView.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                    self.calenderView.customCalenderView.alpha = 1
                }, completion: { _ in
                })
                
                self.calenderView.customCalenderView.select(self.currentCalendarDate)
                self.logbookView.addSubview(self.calenderView)
                self.logbookView.bringSubviewToFront(self.calenderView)
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                    self.calenderView.customCalenderView.alpha = 0
                }, completion: { _ in
                    self.logbookView.headerBlurView.isHidden = true
                    self.calenderView.removeFromSuperview()
                })
            }
        }
        
        //Handling Glucose First Button Tap
        self.logbookView.glucoseFirstBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.logbookView.detailCardContainerView.alpha = 0
            self.logbookView.detailCardContainerView.isHidden = false
            self.logbookView.shapeLayer?.removeFromSuperlayer()
            guard let latestReading = self.elementAtIndex(readings: self.latestGlucoseReadings, at: 0) else { return }
            self.logbookView.animateSlidingLinkView(dataView: self.logbookView.glucoseButtonOneView)
            self.logbookView.setupDetailView(reading: latestReading)
            self.showDetailsView(button: button)
            
        }
        
        //Handling Glucose Second Button Tap
        self.logbookView.glucoseSecondBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.logbookView.detailCardContainerView.alpha = 0
            self.logbookView.detailCardContainerView.isHidden = false
            self.logbookView.shapeLayer?.removeFromSuperlayer()
            guard let latestReading = self.elementAtIndex(readings: self.latestGlucoseReadings, at: 1) else { return }
            self.logbookView.setupDetailView(reading: latestReading)
            self.logbookView.animateSlidingLinkView(dataView: self.logbookView.glucoseButtonTwoView)
            self.showDetailsView(button: button)
        }
        
        //Handling Glucose Third Button Tap
        self.logbookView.glucoseThirdBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.logbookView.detailCardContainerView.alpha = 0
            self.logbookView.detailCardContainerView.isHidden = false
            self.logbookView.shapeLayer?.removeFromSuperlayer()
            guard let latestReading = self.elementAtIndex(readings: self.latestGlucoseReadings, at: 2) else { return }
            self.logbookView.animateSlidingLinkView(dataView: self.logbookView.glucoseButtonThreeView)
            self.logbookView.setupDetailView(reading: latestReading)
            self.showDetailsView(button: button)
        }
        
        //Handling Carbs First Button Tap
        self.logbookView.carbsFirstBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.logbookView.detailCardContainerView.alpha = 0
            self.logbookView.detailCardContainerView.isHidden = false
            self.logbookView.shapeLayer?.removeFromSuperlayer()
            guard let latestReading = self.elementAtIndex(readings: self.latestCarbsReadings, at: 0) else { return }
            self.logbookView.animateSlidingLinkView(dataView: self.logbookView.carbsFirstView)
            self.logbookView.setupDetailView(reading: latestReading)
            self.showDetailsView(button: button)
        }
        
        //Handling Carbs Second Button Tap
        self.logbookView.carbsSecondBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.logbookView.detailCardContainerView.alpha = 0
            self.logbookView.detailCardContainerView.isHidden = false
            self.logbookView.shapeLayer?.removeFromSuperlayer()
            guard let latestReading = self.elementAtIndex(readings: self.latestCarbsReadings, at: 1) else { return }
            self.logbookView.animateSlidingLinkView(dataView: self.logbookView.carbsSecondView)
            self.logbookView.setupDetailView(reading: latestReading)
            self.showDetailsView(button: button)
        }
        
        //Handling Exercise First Button Tap
        self.logbookView.exerciseFirstBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.logbookView.detailCardContainerView.alpha = 0
            self.logbookView.detailCardContainerView.isHidden = false
            self.logbookView.shapeLayer?.removeFromSuperlayer()
            guard let latestReading = self.elementAtIndex(readings: self.latestExerciseReadings, at: 0) else { return }
            self.logbookView.animateSlidingLinkView(dataView: self.logbookView.exerciseFirstView)
            self.logbookView.setupDetailView(reading: latestReading)
            self.showDetailsView(button: button)
        }
        
        //Handling Exercise Second Button Tap
        self.logbookView.exerciseSecondBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.logbookView.detailCardContainerView.alpha = 0
            self.logbookView.detailCardContainerView.isHidden = false
            self.logbookView.shapeLayer?.removeFromSuperlayer()
            guard let latestReading = self.elementAtIndex(readings: self.latestExerciseReadings, at: 1) else { return }
            self.logbookView.animateSlidingLinkView(dataView: self.logbookView.exerciseSecondView)
            self.logbookView.setupDetailView(reading: latestReading)
            self.showDetailsView(button: button)
        }
    }
    
    ///Sets up logBook Card View
    func setupLogbookDetailCardView() {
        self.logbookView.logbookDetailDataView.frame = CGRect(x: 0, y: 0, width: self.logbookView.detailCardContainerView.width, height: 70)
        self.logbookView.detailCardContainerView.addSubview(logbookView.logbookDetailDataView)
    }
    
    func setupSegmentControl() {
        switch logbookView.segmentState {
        case .days:
            self.logbookView.backgroundHazleView.transform = CGAffineTransform.init(translationX: self.logbookView.dayButton.frame.minX, y: 0)
        case .weeks:
            self.logbookView.backgroundHazleView.transform = CGAffineTransform.init(translationX: self.logbookView.weekButton.frame.minX, y: 0)
        case .months:
            self.logbookView.backgroundHazleView.transform = CGAffineTransform.init(translationX: self.logbookView.monthButton.frame.minX, y: 0)
        case .years:
            self.logbookView.backgroundHazleView.transform = CGAffineTransform.init(translationX: self.logbookView.yearButton.frame.minX, y: 0)
        }
    }
    
    ///Returns ReadingDetail at Index
    func elementAtIndex(readings: [ReadingsDetail], at index: Int) -> ReadingsDetail?{
        if index >= readings.count {
            return nil
        } else {
            return readings[readings.count - (index + 1)]
        }
    }
    
    func setupSelectedWeekday(date: Date) {
        let weekDays = self.calenderView.customCalenderView.calendarWeekdayView.weekdayLabels
        let index = Calendar.current.component(.weekday, from: date)
        for day in weekDays {
            if day == weekDays[index-1] {
                day.textColor = AppColors.pinkishOrange
            } else {
                day.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
            }
        }
    }
    
    ///Updates LogBook Data
    @objc func updateLogbook() {
        getReadingsData()
    }
}

extension LogbookViewController {
    
    ///Shows LogBook Details View
    func showDetailsView(button: UIButton) {
        if self.currentAnimationButton != button {
            self.animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: {
                self.logbookView.detailCardContainerView.alpha = 1
                self.currentAnimationButton = button
                CommonFunctions.delay(delay: 2) {
                    if self.currentAnimationButton == button {
                    }
                }
            })
            self.animator.startAnimation()
        } else {
            self.animator.stopAnimation(true)
            hideDetailsView(button: button)
        }
    }
    
    ///Hides LogBook Details View
    func hideDetailsView(button: UIButton) {
        self.animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: {
            self.logbookView.detailCardContainerView.alpha = 0
            self.logbookView.shapeLayer?.removeFromSuperlayer()
            self.currentAnimationButton = nil
        })
        self.animator.startAnimation()
    }
}

// MARK: - FSCalendar Delegate& Datasource
//================================================
extension LogbookViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            self.calenderView.customCalenderView.setCurrentPage(date, animated: true)
        }
        let newDate = date.convertToStringForCalendar().toDate(dateFormat: Date.DateFormat.yyyyMMddHHmmss.rawValue) ?? date
        self.setupSelectedWeekday(date: newDate)
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
            self.calenderView.customCalenderView.alpha = 0
        }, completion: { _ in
            self.logbookView.headerBlurView.isHidden = true
            self.calenderView.removeFromSuperview()
        })
        self.currentCalendarDate = newDate
        self.getReadingsData(date: newDate)
        if logbookView.segmentState == .days {
            logbookView.setupGraphImages(visible: false)
        } else {
            logbookView.setupGraphImages(visible: true)
        }
        self.logbookView.setupHeaderText(date: self.currentCalendarDate)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if (NSCalendar.current as NSCalendar).components(.month, from: date).month ?? 0 == (NSCalendar.current as NSCalendar).components(.month, from: self.calenderView.customCalenderView.currentPage).month ?? 0 {
            return UIColor.init(light: .black, dark: .white)
        } else {
            return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.8189206286)
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return AppColors.pinkishOrange
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if dateSet.contains(date.localDate().toString(dateFormat: "yyyy-MM-dd")) {
            return 1
        }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
        return [AppColors.pinkishOrange]
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        return [AppColors.pinkishOrange]
    }
}

// MARK: - UIScrollView Delegate
//================================================
extension LogbookViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let verticalIndicator = scrollView.subviews[(scrollView.subviews.count - 1)]
        verticalIndicator.backgroundColor = UIColor(light: AppColors.black, dark: AppColors.white)
        self.logbookView.detailCardContainerView.alpha = 0
        self.logbookView.shapeLayer?.removeFromSuperlayer()
    }
}


