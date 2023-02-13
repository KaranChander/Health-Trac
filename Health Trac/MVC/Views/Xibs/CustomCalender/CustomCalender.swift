//
//  CustomCalender.swift
//   Health Track


import UIKit
import FSCalendar

class CustomCalender: UIView {

    // MARK: - IBOutlets
    //==================================================
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var customCalenderView: FSCalendar!
    @IBOutlet weak var leftArrowButton: UIButton!
    @IBOutlet weak var rightArrowButton: UIButton!
    
    // MARK: - Variables
    //==================================================
    var previousMonthBtnTapped: ((UIButton) -> Void)?
    var nextMonthBtnTapped: ((UIButton) -> Void)?
    private var currentPage: Date?

    private lazy var today: Date = {
        return Date()
    }()

    
    // MARK: - ViewLifeCycle
    //===============================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    class func instanceFromNib() -> CustomCalender {
        return UINib(nibName: "CustomCalender", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomCalender
    }

    // MARK: - IBActions
    //===============================

    @IBAction func previousMonthButtonTapped(_ sender: UIButton) {
        self.moveCurrentPage(moveUp: false)
        if let handler = self.previousMonthBtnTapped {
            handler(sender)
        }
    }
    
    @IBAction func nextMonthButtonTapped(_ sender: UIButton) {
        self.moveCurrentPage(moveUp: true)
        if let handler = self.nextMonthBtnTapped {
            handler(sender)
        }
    }
    
    // MARK: - Functions
    //==================================
    
    ///Initial setup for xib
    func initialSetup() {
        setupCalender()
    }
    
    ///Function to setup calendar
    func setupCalender() {
        customCalenderView.backgroundColor = UIColor.clear
        customCalenderView.scrollEnabled = false
        customCalenderView.scope = .month
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        //font and color setup
        customCalenderView.appearance.headerTitleColor = UIColor.init(light: .black, dark: .white)
        customCalenderView.appearance.headerTitleFont = AppFonts.Montserrat_Regular.withSize(18)
        customCalenderView.appearance.weekdayTextColor = UIColor.init(light: .black, dark: .white)
        customCalenderView.appearance.weekdayFont = AppFonts.Montserrat_Medium.withSize(18)
        customCalenderView.appearance.caseOptions = .weekdayUsesSingleUpperCase
        customCalenderView.appearance.subtitleTodayColor = UIColor.init(light: .black, dark: .white)
        customCalenderView.appearance.titleFont = AppFonts.Montserrat_Medium.withSize(18)
        leftArrowButton.tintColor = UIColor.init(light: .black, dark: .white)
        rightArrowButton.tintColor = UIColor.init(light: .black, dark: .white)

        // hide the side months from header
        customCalenderView.appearance.headerMinimumDissolvedAlpha = 0.0
    }
    
    ///function too move to currentPage
    private func moveCurrentPage(moveUp: Bool) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.customCalenderView.setCurrentPage(self.currentPage!, animated: true)
        self.currentPage = customCalenderView.currentPage
    }
}
