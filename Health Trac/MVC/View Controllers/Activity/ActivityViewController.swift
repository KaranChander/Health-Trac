//
//  ActivityViewController.swift
//   Health Track
// 
import UIKit
import FSCalendar

class ActivityViewController: BaseVC {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var activityView: ActivityView!
    
    // MARK: - Properties
    //====================================================
    var calenderView = CustomCalender.instanceFromNib()
    var readingsArray = [ReadingsDetail]()
    var sections: [(date: Date, items: [ReadingsDetail])] = []
    var currentCalendarDate = Date()
    
    var dateSet: Set<String> = []
    
    // MARK: - Lifecycle Methods
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getReadingsData(date: self.currentCalendarDate.localDate())
        self.activityView.activityTableView.reloadData()
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Initial setup of VC
    func initialSetup() {
        calenderView.customCalenderView.delegate = self
        calenderView.customCalenderView.dataSource = self
        self.setupSelectedWeekday(date: Date().localDate())
        self.getReadingsData()
        self.actions()
        self.registerXibs()
        self.activityView.activityTableView.delegate = self
        self.activityView.activityTableView.dataSource = self
    }
    
    
    ///Handles IBActions of the view
    func actions() {
        
        //Handling Calender Button Tap
        self.activityView.calenderBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.calenderView.customCalenderView.reloadData()
            if self.activityView.headerBlurView.isHidden == true {
                self.activityView.headerBlurView.isHidden = false
                self.calenderView.frame = CGRect(x: 0, y: 120, width: self.activityView.width, height: self.activityView.height)
                self.calenderView.customCalenderView.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                    self.calenderView.customCalenderView.alpha = 1
                }, completion: { _ in
                })
                
                self.calenderView.customCalenderView.select(self.currentCalendarDate)
                self.activityView.addSubview(self.calenderView)
                self.activityView.bringSubviewToFront(self.calenderView)
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                    self.calenderView.customCalenderView.alpha = 0
                }, completion: { _ in
                    self.activityView.headerBlurView.isHidden = true
                    self.calenderView.removeFromSuperview()
                })
            }
        }
    }
    
    ///Registers Xib Files
    func registerXibs() {
        self.activityView.activityTableView.registerCell(with: ActivityReadingCell.self)
        self.activityView.activityTableView.registerCell(with: ActivityTimeHeaderViewCell.self)
        self.activityView.activityTableView.registerCell(with: UpcomingReadingCell.self)
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
}


// MARK: - TableView Delegate& Datasource
//================================================
extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.currentCalendarDate.convertToFormattedString() == Date().localDate().convertToFormattedString() {
            return sections.count
        } else {
            return sections.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueCell(with: ActivityTimeHeaderViewCell.self)
        headerCell.populateCell(date: sections[self.currentCalendarDate.convertToFormattedString() == Date().localDate().convertToFormattedString() ? section : section].date)
        return headerCell.contentView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: ActivityReadingCell.self, indexPath: indexPath)
        var latestReading = false
        if indexPath == IndexPath.init(row: 0, section: 0) {
            latestReading = true
        }
        cell.populateCell(model: self.sections[self.currentCalendarDate.convertToFormattedString() == Date().localDate().convertToFormattedString() ? indexPath.section : indexPath.section].items[indexPath.row], latest: latestReading)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model = ReadingsDetail()
        model = sections[indexPath.section].items[indexPath.row]
        if model.readingType == ReadingsType.glucose.rawValue {
            let scene = ReadingViewController.instantiate(fromAppStoryboard: .ReadingEntry)
            scene.isComingFromActivityTab = true
            scene.detailModel = model
            navigationController?.pushViewController(scene, animated: true)
        } else if model.readingType == ReadingsType.exercise.rawValue {
            let scene = ExerciseViewController.instantiate(fromAppStoryboard: .ReadingEntry)
            scene.isComingFromActivityTab = true
            scene.detailModel = model
            navigationController?.pushViewController(scene, animated: true)
        } else if model.readingType == ReadingsType.carbs.rawValue {
            let scene = CarbsViewController.instantiate(fromAppStoryboard: .ReadingEntry)
            scene.isComingFromActivityTab = true
            scene.detailModel = model
            navigationController?.pushViewController(scene, animated: true)
        }
    }
}

// MARK: - FSCalendar Delegate& Datasource
//================================================
extension ActivityViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            self.calenderView.customCalenderView.setCurrentPage(date, animated: true)
        }
        let newDate = date.convertToStringForCalendar().toDate(dateFormat: Date.DateFormat.yyyyMMddHHmmss.rawValue) ?? date
        self.setupSelectedWeekday(date: newDate)
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
            self.calenderView.customCalenderView.alpha = 0
        }, completion: { _ in
            self.activityView.headerBlurView.isHidden = true
            self.calenderView.removeFromSuperview()
        })
        self.currentCalendarDate = newDate
        self.getReadingsData(date: newDate)
        self.activityView.setupHeaderText(date: self.currentCalendarDate)
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

