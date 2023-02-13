//
//  ReadingViewController.swift
//   Health Track

import UIKit

class ReadingViewController: UIViewController {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var readingView: ReadingView!
    
    // MARK: - Variables
    //====================================================
    private var readingOneVC: ReadingStepOne!
    private var readingTwoVC: ReadingStepTwo!
    private var readingThreeVC: ReadingStepThree!
    private var readingFourVC: ReadingStepFour!
    var model = ReadingsModel()
    var isComingFromActivityTab: Bool = false
    var isComingFromAutomaticGlucoseReading: Bool = false
    var detailModel = ReadingsDetail()
    
    // MARK: - ViewLifeCycle
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        printDebug(self.readingView.frame.height)
        self.readingView.readingScrollView.delegate = self
        setupSubviews()
        actions()
        fromActivityTab()
        if isComingFromAutomaticGlucoseReading {
            fromAutomaticGlucoseReading()
        }
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Handles when user taps exercise cell in activity tab
    func fromActivityTab() {
        if isComingFromActivityTab {
            self.readingView.readingScrollView.setContentOffset(CGPoint(x:self.readingView.width*3 , y: 0), animated: false)
            self.readingView.navigationBar.rightLabel.isHidden = true
            self.readingView.nextLabel.isHidden = true
            self.readingView.nextImage.isHidden = true
            self.readingFourVC.setupViewWithData(model: detailModel)
        }
    }
    
    ///Handles when user taps automatic glucose reading
    func fromAutomaticGlucoseReading() {
        self.readingView.readingScrollView.setContentOffset(CGPoint(x:self.readingView.width*2 , y: 0), animated: false)
    }
    
    ///Handles IBActions from the view
    func actions() {
        
        //Handling Next Button Tap
        self.readingView.nextButtonTapped = { [weak self] (button) in
            guard let `self` = self else { return }
            switch self.readingView.readingScrollView.contentOffset.x {
                
                ///STEP ONE GLUCOSE READING
            case 0:
                self.readingOneVC.nextTapped()
                self.model.id = ReadingsDetail.createId() ?? 1
                self.model.createdAt = self.readingOneVC.createdAt
                self.model.createdDateString = self.readingOneVC.createdDateString
                self.model.readingType = self.readingOneVC.readingType
                self.readingTwoVC.readingStepwoView.pickerLeadingConstraint.constant = -9
                DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {
                    self.readingTwoVC.readingStepwoView.setupDatePicker()
                }
                self.readingView.readingScrollView.setContentOffset(CGPoint(x:self.readingView.width , y: 0), animated: true)
                
                ///STEP TWO GLUCOSE READING
            case self.readingView.width:
                self.readingTwoVC.nextTapped()
                self.model.glucoseReading = self.readingTwoVC.glucoseReading
                self.model.glucoseUnit = self.readingTwoVC.glucoseUnit
                self.model.glucoseReadingType = self.readingTwoVC.readingType
                self.readingView.readingScrollView.setContentOffset(CGPoint(x:self.readingView.width*2 , y: 0), animated: true)
                
                ///STEP THREE GLUCOSE READING
            case self.readingView.width*2:
                self.readingThreeVC.nextTapped()
                self.model.userDescription = self.readingThreeVC.userDescription
                self.readingFourVC.setupViewWithData(model: self.model)
                self.readingView.readingScrollView.setContentOffset(CGPoint(x:self.readingView.width*3 , y: 0), animated: true)
                
                ///STEP FOUR GLUCOSE READING
            case self.readingView.width*3:
                self.navigationController?.popToRootViewController(animated: true)
                NotificationCenter.default.post(name: Notification.Name(StringConstant.hidePopUp.value), object: nil)
                ReadingsDetail.saveReadingData(readingsModel: self.model)
                NotificationCenter.default.post(name: NSNotification.Name(StringConstant.updateHomeView.value), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name(StringConstant.updateLogBook.value), object: nil)
                
            default:
                self.readingView.readingScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }
        
        //Handling Back Button Tap
        self.readingView.navigationBar.backButtonTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            switch self.readingView.readingScrollView.contentOffset.x {
                
                ///STEP ONE GLUCOSE READING
            case 0:
                self.navigationController?.popViewController(animated: true)
                
                ///STEP TWO GLUCOSE READING
            case self.readingView.frame.width:
                self.readingView.setupNextButton()
                self.readingTwoVC.readingStepwoView.pickerLeadingConstraint.constant = 0
                self.readingView.readingScrollView.setContentOffset(CGPoint(x:0 , y: 0), animated: true)
                
                ///STEP THREE GLUCOSE READING
            case self.readingView.frame.width*2:
                if self.isComingFromAutomaticGlucoseReading {
                    self.showAlert(title: StringConstant.discardChanges.value, msg: StringConstant.discardChangesDesc.value, cancelTitle: "No", actionTitle: "Yes") {
                        self.navigationController?.popToRootViewController(animated: true)
                    } cancelcompletion: {
                        self.dismiss(animated: true, completion: nil)
                    }
                    NotificationCenter.default.post(name: Notification.Name(StringConstant.hidePopUp.value), object: nil)
                } else {
                    self.readingView.setupNextButton()
                    self.readingView.readingScrollView.setContentOffset(CGPoint(x:self.readingView.width , y: 0), animated: true)
                }
                
                ///STEP FOUR GLUCOSE READING
            case self.readingView.frame.width*3:
                if self.isComingFromActivityTab {
                    self.navigationController?.popViewController(animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        NotificationCenter.default.post(name: NSNotification.Name(StringConstant.comingFromActivity.value), object: nil)
                    }
                } else {
                    if self.isComingFromActivityTab {
                        self.navigationController?.popViewController(animated: true)
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                            NotificationCenter.default.post(name: NSNotification.Name(StringConstant.comingFromActivity.value), object: nil)
                        }
                    } else {
                        self.readingView.setupNextButton()
                        self.readingView.readingScrollView.setContentOffset(CGPoint(x:self.readingView.width*2 , y: 0), animated: true)
                    }
                }
                
            default:
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    ///Sets Up subviews on scrolllView
    func setupSubviews() {
        self.readingView.layoutSubviews()
        self.readingView.layoutIfNeeded()
        self.readingView.readingScrollView.layoutIfNeeded()
        self.readingView.readingScrollView.isPagingEnabled = true
        self.readingView.readingScrollView.frame.size = CGSize(width: self.readingView.width, height: self.readingView.readingScrollView.height)
        self.readingView.readingScrollView.contentSize = CGSize(width: self.readingView.width*4, height: self.readingView.readingScrollView.height)
        
        //StepOneVC Setup
        readingOneVC = ReadingStepOne.instantiate(fromAppStoryboard: .ReadingEntry)
        readingOneVC.view.frame = CGRect(x: 0, y: 0, width: self.readingView.readingScrollView.frame.width, height: self.readingView.readingScrollView.frame.height)
        self.addChild(readingOneVC)
        self.readingView.readingScrollView.addSubview(readingOneVC.view)
        
        //StepTwoVC Setup
        readingTwoVC = ReadingStepTwo.instantiate(fromAppStoryboard: .ReadingEntry)
        readingTwoVC.view.frame = CGRect(x: (self.readingView.readingScrollView.frame.width), y: 0, width: self.readingView.readingScrollView.frame.width, height: self.readingView.readingScrollView.frame.height)
        self.addChild(readingTwoVC)
        self.readingView.readingScrollView.addSubview(readingTwoVC.view)
        
        //StepThreeVC Setup
        readingThreeVC = ReadingStepThree.instantiate(fromAppStoryboard: .ReadingEntry)
        readingThreeVC.view.frame = CGRect(x: (self.readingView.readingScrollView.frame.width*2), y: 0, width: self.readingView.readingScrollView.frame.width, height: self.readingView.readingScrollView.frame.height)
        self.addChild(readingThreeVC)
        self.readingView.readingScrollView.addSubview(readingThreeVC.view)
        
        //StepFourVC Setup
        readingFourVC = ReadingStepFour.instantiate(fromAppStoryboard: .ReadingEntry)
        readingFourVC.view.frame = CGRect(x: (self.readingView.readingScrollView.frame.width*3), y: 0, width: self.readingView.readingScrollView.frame.width, height: self.readingView.readingScrollView.frame.height)
        self.addChild(readingFourVC)
        self.readingView.readingScrollView.addSubview(readingFourVC.view)
    }
}

// MARK: - UIScrollViewDelegate Delegate
//====================================================
extension ReadingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView.contentOffset.x {
        case 0:
            self.readingView.navigationBar.stepNumberText = StringConstant.oneByFour.value
        case self.readingView.frame.width:
            self.readingView.navigationBar.stepNumberText = StringConstant.twoByFour.value
        case self.readingView.frame.width*2:
            self.readingView.navigationBar.stepNumberText = StringConstant.threeByFour.value
        case self.readingView.frame.width*3:
            self.readingView.navigationBar.stepNumberText = StringConstant.fourByFour.value
            self.readingView.setupDoneButton()
        default:
            self.readingView.navigationBar.stepNumberText = self.readingView.navigationBar.stepNumberText
        }
    }
}
