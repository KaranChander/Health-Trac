//
//  TabBarViewController.swift
//   Health Track


import UIKit
import Realm
import RealmSwift
import TrueTime

enum TabBarState {
    case home
    case activity
    case logbook
    case settings
}

class TabBarViewController: UIViewController {
    
    // MARK: - IBOutlets
    //======================================================
    @IBOutlet var tabBarView: TabBarView!
    
    // MARK: - Properties
    //=======================================================
    private var homeVCScene: HomeViewController!
    private var activityVCScene: ActivityViewController!
    private var logBookVCScene: LogbookViewController!
    private var settingsVCScene: SettingsViewController!
    var currentState: TabBarState = .home
    
    // MARK: - Lifecycle Methods
    //=======================================================
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarView.currentState = self.currentState
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isHidden = true
        if let darkModeEnable = AppUserDefaults.value(forKey: .darkModeEnable).bool {
            if darkModeEnable {
                if #available(iOS 13.0, *) {
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                } else {
                    // Fallback on earlier versions
                }
            } else {
                if #available(iOS 13.0, *) {
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                } else {
                    // Fallback on earlier versions
                }
            }
        } else {
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                AppUserDefaults.save(value: true, forKey: .darkModeEnable)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parseJSON()
        setupSubview()
        initialSetup()
        buildValues()
        buildCarbsValues()
    }
    
    
    // MARK: - Functions
    //================================================
    
    ///Initial Setup Of VC
    func initialSetup() {
        self.actions()
        // realm keys for development
        printDebug(AppDelegate.shared.getKey().hexadecimal)
        printDebug(Realm.Configuration.defaultConfiguration.fileURL!)
        NotificationCenter.default.addObserver(self, selector: #selector(hidePopUp), name: NSNotification.Name(StringConstant.hidePopUp.value), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(comingFromActivity), name: NSNotification.Name(StringConstant.comingFromActivity.value), object: nil)
    }
    
    ///Handles IBActions of the View
    func actions() {
        
        //Handling Home Button Tap
        self.tabBarView.homeBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.logBookVCScene.hideDetailsView(button: UIButton())
            if self.tabBarView.middleExpandButtonView.isSelected {
                self.tabBarView.middleButtonTapped(self.tabBarView.middleExpandButtonView)
            }
            if self.currentState != .home {
                if self.currentState == .activity {
                    self.homeVCScene.currentCalendarDate = self.activityVCScene.currentCalendarDate
                } else if self.currentState == .logbook {
                    self.homeVCScene.currentCalendarDate = self.logBookVCScene.currentCalendarDate
                }
                self.homeVCScene.getReadingsData(date: self.homeVCScene.currentCalendarDate.localDate())
                self.homeVCScene.homeView.setupHeaderText(date: self.homeVCScene.currentCalendarDate.localDate())
                self.currentState = .home
                self.tabBarView.currentState = self.currentState
                self.logBookVCScene.logbookView.logbookScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
        }
        
        //Handling Glucose Reading Button Tap
        self.tabBarView.readingBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            let scene = ReadingViewController.instantiate(fromAppStoryboard: .ReadingEntry)
            self.navigationController?.pushViewController(scene, animated: true)
        }
        
        //Handling Exercise Reading Button Tap
        self.tabBarView.exerciseBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            let scene = ExerciseViewController.instantiate(fromAppStoryboard: .ReadingEntry)
            self.navigationController?.pushViewController(scene, animated: true)
        }
        
        //Handling Carbs Reading Button Tap
        self.tabBarView.carbsBtnTapped = { [weak self] (button) in
            guard let `self` = self else { return }
            let scene = CarbsViewController.instantiate(fromAppStoryboard: .ReadingEntry)
            self.navigationController?.pushViewController(scene, animated: true)
        }
        
        //Handling Activity Button Tap
        self.tabBarView.activityBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.logBookVCScene.hideDetailsView(button: UIButton())
            if self.tabBarView.middleExpandButtonView.isSelected {
                self.tabBarView.middleButtonTapped(self.tabBarView.middleExpandButtonView)
            }
            if self.currentState != .activity {
                if self.currentState == .home {
                    self.activityVCScene.currentCalendarDate = self.homeVCScene.currentCalendarDate
                } else if self.currentState == .logbook {
                    self.activityVCScene.currentCalendarDate = self.logBookVCScene.currentCalendarDate
                }
                self.activityVCScene.getReadingsData(date: self.activityVCScene.currentCalendarDate.localDate())
                self.activityVCScene.activityView.setupHeaderText(date: self.activityVCScene.currentCalendarDate.localDate())
                self.currentState = .activity
                self.tabBarView.currentState = self.currentState
                self.logBookVCScene.logbookView.logbookScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
        }
        
        //Handling LogBook Button Tap
        self.tabBarView.logbookBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.logBookVCScene.setupSegmentControl()
            if self.tabBarView.middleExpandButtonView.isSelected {
                self.tabBarView.middleButtonTapped(self.tabBarView.middleExpandButtonView)
            }
            
            if self.currentState != .logbook {
                if self.currentState == .home {
                    self.logBookVCScene.currentCalendarDate = self.homeVCScene.currentCalendarDate
                } else if self.currentState == .activity {
                    self.logBookVCScene.currentCalendarDate = self.activityVCScene.currentCalendarDate
                }
                self.logBookVCScene.getReadingsData(date: self.logBookVCScene.currentCalendarDate.localDate())
                self.logBookVCScene.logbookView.setupHeaderText(date: self.logBookVCScene.currentCalendarDate.localDate())
                self.currentState = .logbook
                self.tabBarView.currentState = self.currentState
                self.logBookVCScene.logbookView.logbookScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
            
            //Handling Settings Button Tap
            self.tabBarView.settingsBtnTapped = {[weak self] (button) in
                guard let `self` = self else { return }
                if self.tabBarView.middleExpandButtonView.isSelected {
                    self.tabBarView.middleButtonTapped(self.tabBarView.middleExpandButtonView)
                }
                self.logBookVCScene.hideDetailsView(button: UIButton())
            }
        }
    }
    
    ///Setup scroll view child VC's
    private func setupSubview() {
        self.tabBarView.layoutSubviews()
        self.tabBarView.layoutIfNeeded()
        self.tabBarView.tabBarScrollView.layoutIfNeeded()
        self.tabBarView.tabBarScrollView.frame.size = CGSize(width: self.tabBarView.width, height: self.tabBarView.tabBarScrollView.height)
        
        ///HomeVC Setup
        homeVCScene = HomeViewController.instantiate(fromAppStoryboard: .Home)
        homeVCScene.view.frame = CGRect(x: 0, y: 0, width: self.tabBarView.tabBarScrollView.frame.width, height: self.tabBarView.tabBarScrollView.frame.height)
        homeVCScene.delegate = self
        self.addChild(homeVCScene)
        self.tabBarView.tabBarScrollView.addSubview(homeVCScene.view)
        
        ///ActivityVC Setup
        activityVCScene = ActivityViewController.instantiate(fromAppStoryboard: .Activity)
        activityVCScene.view.frame = CGRect(x: (self.tabBarView.tabBarScrollView.frame.width), y: 0, width: self.tabBarView.tabBarScrollView.frame.width, height: self.tabBarView.tabBarScrollView.frame.height)
        self.addChild(activityVCScene)
        self.tabBarView.tabBarScrollView.addSubview(activityVCScene.view)
        
        ///LogBookVC Setup
        logBookVCScene = LogbookViewController.instantiate(fromAppStoryboard: .LogBook)
        logBookVCScene.view.frame = CGRect(x: (self.tabBarView.tabBarScrollView.frame.width*2), y: 0, width: self.tabBarView.tabBarScrollView.frame.width, height: self.tabBarView.tabBarScrollView.frame.height)
        self.addChild(logBookVCScene)
        self.tabBarView.tabBarScrollView.addSubview(logBookVCScene.view)
        
        ///SettingsVC Setup
        settingsVCScene = SettingsViewController.instantiate(fromAppStoryboard: .Settings)
        settingsVCScene.view.frame = CGRect(x: (self.tabBarView.tabBarScrollView.frame.width*3), y: 0, width: self.tabBarView.tabBarScrollView.frame.width, height: self.tabBarView.tabBarScrollView.frame.height)
        self.addChild(settingsVCScene)
        self.tabBarView.tabBarScrollView.addSubview(settingsVCScene.view)
    }
    
    ///Builds value for glucose reading picker
    func buildValues() {
        var i: Double = 2.0
        while i <= 13.0 {
            if i == 2.0 {
                AppConstants.mmolValue = [String]()
                AppConstants.mgValue = [String]()
            }
            AppConstants.mmolValue.append(String(format:"%.2f", i))
            i += 0.05
        }
        AppConstants.salivaMmolValue = [String]()
        var z: Double = 0.2
        while z <= 1.31 {
            AppConstants.salivaMmolValue.append(String(format:"%.2f", z))
            z += 0.01
        }
        AppConstants.mgValue = [String]()
        var j: Double = 36
        while j <= 235 {
            AppConstants.mgValue.append(String(format: "%.1f", j))
            j += 0.1
        }
        AppConstants.salivaMgValue = [String]()
        var k: Double = 3.6
        while k <= 24 {
            AppConstants.salivaMgValue.append(String(format: "%.1f", k))
            k += 0.1
        }
    }
    
    
    ///Builds value for Carbs reading picker
    func buildCarbsValues() {
        var i: Int = 1
        while i<=500 {
            if i == 1 {
                AppConstants.carbsValues = [String]()
            }
            AppConstants.carbsValues.append(String(i))
            i+=1
        }
    }
    
    ///Handles notofication when details view is shown from ActivityVC
    @objc func comingFromActivity() {
        self.tabBarView.tabBarScrollView.setContentOffset(CGPoint(x: self.tabBarView.tabBarScrollView.width, y: 0), animated: false)
    }
    
    //Handles notofication to hide popUp view of middle Button
    @objc func hidePopUp() {
        self.tabBarView.middleButtonTapped(self.tabBarView.middleExpandButtonView)
        self.tabBarView.activityButtonTapped(self.tabBarView.activityButtonView)
        self.homeVCScene.calenderView.customCalenderView.reloadData()
        self.activityVCScene.calenderView.customCalenderView.reloadData()
        self.logBookVCScene.calenderView.customCalenderView.reloadData()
    }
}

// MARK: - HomeViewControllerDelegate
//===========================================================================
extension TabBarViewController: HomeVCDelegate {
    func goToActivityScreen(date: Date) {
        self.tabBarView.tabBarScrollView.contentOffset.x = self.tabBarView.tabBarScrollView.width
        self.tabBarView.changeToDefaultColors(imageArray: [tabBarView.homeImageView, tabBarView.logBookImageView, tabBarView.settingsImageView], labelArray: [tabBarView.homeTitleLabel, tabBarView.logBookLabel, tabBarView.settingsLabel])
        self.tabBarView.activityImageView.image = #imageLiteral(resourceName: "activity_purple")
        self.tabBarView.activityLabel.textColor = AppColors.heliotrope
        activityVCScene.currentCalendarDate = date
        activityVCScene.getReadingsData(date: activityVCScene.currentCalendarDate.localDate())
        activityVCScene.activityView.setupHeaderText(date: date)
        self.currentState = .activity
        self.tabBarView.currentState = self.currentState
        UIView.animate(withDuration: 0.5) {
            self.tabBarView.backgroundTabHazleView.transform = CGAffineTransform.init(translationX: self.tabBarView.activityButtonView.globalFrame?.minX ?? 0, y: 0)
        }
    }
}

extension TabBarViewController {
    func parseJSON() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return
        }
        var result: Result?
        let url = URL(fileURLWithPath: path)
        do {
            let data = NSData(contentsOf: url) as Data?
            if let data = data {
                result = try JSONDecoder().decode(Result.self, from: data)
                if let result = result {
                    dump(result)
                    print(result.count)
                    AppConstants.result = result
                    saveJsonINRealm(results: AppConstants.result ?? [])
                } else {
                    print("Failed to parse")
                }
            }
        } catch {
            print("ERROR:  \(error.localizedDescription)")
        }
    }
    
    func saveJsonINRealm(results: Result) {
        let r = ReadingsDetail.getDirectReadingList() ?? []
        if r.isEmpty {
        for result in results {
            guard let day = Int(result.day) else {return}
            let calendar = Calendar.current
            let date = (calendar.date(byAdding: .day, value: -day, to: Date()) ?? Date()).toString(dateFormat: "MMM dd, yyyy")
            for datum in result.data {
                var reading: ReadingsModel = ReadingsModel()
                reading.id = ReadingsDetail.createId() ?? 0
                let localDate = "\(date) - \(datum.time)"
                reading.createdAt = localDate
                reading.createdDateString = reading.createdAt.toDate(dateFormat: Date.DateFormat.MMMdyyyyHHmmssa.rawValue)?.convertToString() ?? ""
                reading.readingType = datum.readingType
                reading.glucoseReading  = Double(datum.glucoseReading) ?? 0.0
                reading.glucoseUnit = datum.glucoseUnit
                reading.userDescription = datum.userDescription
                reading.carbsReading = datum.carbsReading
                reading.glucoseReadingType = datum.glucoseReadingType
                let exercise = ExerciseReading()
                exercise.hours = Int(datum.exerciseReading.hours) ?? 0
                exercise.minutes = Int(datum.exerciseReading.minutes) ?? 0
                reading.exerciseReading = exercise
                
                _ = ReadingsDetail.saveReadingData(readingsModel: reading)
            }
        }
    }
    }
}

