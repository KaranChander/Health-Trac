//
//  HomeViewController.swift
//   Health Track

protocol HomeVCDelegate: AnyObject {
    func goToActivityScreen(date: Date)
}

import UIKit
import FSCalendar

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    //======================================================
    @IBOutlet var homeView: HomeControllerView!
    
    // MARK: - Variables
    //=======================================================
    var calenderView = CustomCalender.instanceFromNib()
    var readingsArray = [GlucoseReading]()
    var currentCalendarDate = Date()
    weak var delegate: HomeVCDelegate?
    var dateSet: Set<String> = []
    var glucoseReadingType = ""
    var readingLevel = ""
    
    // MARK: - Lifecycle Methods
    //=======================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Functions
    //================================================
    
    ///Initial setup of VC
    func initialSetup() {
        self.actions()
        homeView.backgroundColor = UIColor(light: .white , dark: .black)
        homeView.homeReadCollectionView.delegate = self
        homeView.homeReadCollectionView.dataSource = self
        homeView.homeReadCollectionView.registerCell(with: HomeReadCell.self)
        self.setupSelectedWeekday(date: Date().localDate())
        self.getReadingsData()
        if readingLevel.count != 0 && glucoseReadingType.count != 0 {
            homeView.setupStatusLabel(status: readingLevel, readingType: glucoseReadingType)
        }
        setupCalendarView()
        NotificationCenter.default.addObserver(self, selector: #selector(updateHomeNotificationReceived), name: NSNotification.Name(StringConstant.updateHomeView.value), object: nil)
    }
    
    ///Handles IBActions of the view
    func actions() {
        
        //Handling Calender Button Tap
        self.homeView.calendarBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            if self.homeView.calendarTopBlurView.isHidden == true {
                self.homeView.calendarTopBlurView.isHidden = false
                self.calenderView.frame = CGRect(x: 0, y: 120, width: self.homeView.width, height: self.homeView.height)
                self.calenderView.customCalenderView.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                    self.calenderView.customCalenderView.alpha = 1
                }, completion: { _ in
                })
                self.calenderView.customCalenderView.select(self.currentCalendarDate)
                self.homeView.addSubview(self.calenderView)
                self.homeView.bringSubviewToFront(self.calenderView)
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                    self.calenderView.customCalenderView.alpha = 0
                }, completion: { _ in
                    self.homeView.calendarTopBlurView.isHidden = true
                    self.calenderView.removeFromSuperview()
                })
            }
        }
        
        //Handling Time Header Button Tap
        self.homeView.timeHeaderBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.delegate?.goToActivityScreen(date: self.currentCalendarDate)
        }
    }
    
    ///Assigning calender delegate and datasource
    func setupCalendarView() {
        calenderView.customCalenderView.delegate = self
        calenderView.customCalenderView.dataSource = self
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
    
    ///Handling updation on homeView when notification is received
    @objc func updateHomeNotificationReceived() {
        self.getReadingsData()
        if readingLevel.count != 0 && glucoseReadingType.count != 0 {
            homeView.setupStatusLabel(status: readingLevel, readingType: glucoseReadingType)
        }
        self.homeView.updateCollectionViewValues()
    }
}

// MARK: - CollectionView Delegate & DataSource
//================================================
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.readingsArray.count >= 1 {
            return 2
        } else {
            return self.readingsArray.isEmpty ? 1 : self.readingsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: HomeReadCell.self, indexPath: indexPath)
        if self.readingsArray.isEmpty {
            self.homeView.glucoseTypeLabel.text = "-"
            cell.setupEmptyCell()
        } else {
            cell.populateCell(model: self.readingsArray[indexPath.row], row: indexPath.row)
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let layout = self.homeView.homeReadCollectionView.collectionViewLayout as! CarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.homeView.pageSize.width : self.homeView.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        homeView.currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        homeView.updateGlucoseTypeLabel(index: homeView.currentPage)
    }
}

// MARK: - FSCalendar Delegate& Datasource
//================================================
extension HomeViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            self.calenderView.customCalenderView.setCurrentPage(date, animated: true)
        }
        let newDate = date.convertToStringForCalendar().toDate(dateFormat: Date.DateFormat.yyyyMMddHHmmss.rawValue) ?? date
        self.setupSelectedWeekday(date: newDate)
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
            self.calenderView.customCalenderView.alpha = 0
        }, completion: { _ in
            self.homeView.calendarTopBlurView.isHidden = true
            self.calenderView.removeFromSuperview()
        })
        self.currentCalendarDate = newDate
        self.getReadingsData(date: newDate)
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

