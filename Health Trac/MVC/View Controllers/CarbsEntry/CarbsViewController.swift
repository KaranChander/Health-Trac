//
//  CarbsViewController.swift
//   Health Track


import UIKit

class CarbsViewController: UIViewController {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var carbsView: CarbsView!
    
    // MARK: - Variables
    //====================================================
    private var carbsOneVC: CarbsStepOne!
    private var carbsTwoVC: CarbsStepTwo!
    private var carbsThreeVC: CarbsStepThree!
    private var carbsFourVC: CarbsStepFour!
    private var carbsFiveVC: CarbsStepFive!
    var model = ReadingsModel()
    var isComingFromActivityTab: Bool = false
    var detailModel = ReadingsDetail()
    
    // MARK: - ViewLifeCycle
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.carbsView.carbsScrollView.delegate = self
        setupSubviews()
        actions()
        fromActivityTab()
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Handles when user taps carbs cell in activity tab
    func fromActivityTab() {
        if isComingFromActivityTab {
            self.carbsView.carbsScrollView.setContentOffset(CGPoint(x:self.carbsView.width*3 , y: 0), animated: false)
            self.carbsView.navigationBar.rightLabel.isHidden = true
            self.carbsView.nextLabel.isHidden = true
            self.carbsView.nextImage.isHidden = true
            self.carbsView.nextButton.isHidden = true
            self.carbsFiveVC.setupViewWithData(model: detailModel)
        }
    }
    
    ///Handles IBActions from the view
    func actions() {
        
        //Handling Next Button Tap
        self.carbsView.nextButtonTapped = { [weak self] (button) in
            guard let `self` = self else { return }
            switch self.carbsView.carbsScrollView.contentOffset.x {
            
            ///STEP ONE CARBS READING
            case 0:
                self.carbsOneVC.nextTapped()
                self.carbsTwoVC.carbsStepTwoView.pickerLeadingConstraint.constant = -9
                DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {
                    self.carbsTwoVC.carbsStepTwoView.setupDatePicker()
                }
                self.carbsView.carbsScrollView.setContentOffset(CGPoint(x:self.carbsView.width , y: 0), animated: true)
                self.model.id = ReadingsDetail.createId() ?? 1
                self.model.createdAt = self.carbsOneVC.createdAt
                self.model.createdDateString = self.carbsOneVC.createdDateString
                self.model.readingType = self.carbsOneVC.readingType
                
            ///STEP TWO CARBS READING
            case self.carbsView.width:
                self.carbsTwoVC.nextTapped()
                self.model.carbsReading = self.carbsTwoVC.carbsReading
                let scene = CarbsStepThree.instantiate(fromAppStoryboard: .ReadingEntry)
                scene.model = self.model
                self.navigationController?.pushViewController(scene, animated: true)
                
            ///STEP FOUR CARBS READING
            case self.carbsView.width*2:
                self.carbsFourVC.nextTapped()
                self.model.userDescription = self.carbsFourVC.userDescription
                self.carbsView.carbsScrollView.setContentOffset(CGPoint(x:self.carbsView.width*3 , y: 0), animated: true)
                self.carbsFiveVC.setupViewWithData(model: self.model)
                
            ///STEP FIVE CARBS READING
            case self.carbsView.width*3:
                self.navigationController?.popToRootViewController(animated: true)
                NotificationCenter.default.post(name: Notification.Name(StringConstant.hidePopUp.value), object: nil)
                ReadingsDetail.saveReadingData(readingsModel: self.model)
                NotificationCenter.default.post(name: NSNotification.Name(StringConstant.updateLogBook.value), object: nil)
                
            default:
                self.carbsView.carbsScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }
        
        //Handling Back Button Tap
        self.carbsView.navigationBar.backButtonTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            switch self.carbsView.carbsScrollView.contentOffset.x {
            
            ///STEP ONE CARBS READING
            case 0:
                self.navigationController?.popToRootViewController(animated: true)
                NotificationCenter.default.post(name: NSNotification.Name(StringConstant.hidePopUp.value), object: nil)
                
            ///STEP TWO CARBS READING
            case self.carbsView.frame.width:
                self.carbsView.setupNextButton()
                self.carbsTwoVC.carbsStepTwoView.pickerLeadingConstraint.constant = 0
                self.carbsView.carbsScrollView.setContentOffset(CGPoint(x:0 , y: 0), animated: true)
                
            ///STEP FOUR CARBS READING
            case self.carbsView.frame.width*2:
                self.carbsView.setupNextButton()
                self.navigationController?.popViewController(animated: true)
                
            ///STEP FIVE CARBS READING
            case self.carbsView.frame.width*3:
                if self.isComingFromActivityTab {
                    self.navigationController?.popViewController(animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        NotificationCenter.default.post(name: NSNotification.Name(StringConstant.comingFromActivity.value), object: nil)
                    }
                } else {
                    self.carbsView.setupNextButton()
                    self.carbsView.carbsScrollView.setContentOffset(CGPoint(x:self.carbsView.width*2 , y: 0), animated: true)
                }
                
            default:
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    ///Sets Up subviews on scrolllView
    func setupSubviews() {
        self.carbsView.layoutSubviews()
        self.carbsView.layoutIfNeeded()
        self.carbsView.carbsScrollView.layoutIfNeeded()
        self.carbsView.carbsScrollView.isPagingEnabled = true
        self.carbsView.carbsScrollView.frame.size = CGSize(width: self.carbsView.width, height: self.carbsView.carbsScrollView.height)
        self.carbsView.carbsScrollView.contentSize = CGSize(width: self.carbsView.width*4, height: self.carbsView.carbsScrollView.height)
        
        ///StepOneVC Setup
        carbsOneVC = CarbsStepOne.instantiate(fromAppStoryboard: .ReadingEntry)
        carbsOneVC.view.frame = CGRect(x: 0, y: 0, width: self.carbsView.carbsScrollView.frame.width, height: self.carbsView.carbsScrollView.frame.height)
        self.addChild(carbsOneVC)
        self.carbsView.carbsScrollView.addSubview(carbsOneVC.view)
        
        ///StepTwoVC Setup
        carbsTwoVC = CarbsStepTwo.instantiate(fromAppStoryboard: .ReadingEntry)
        carbsTwoVC.view.frame = CGRect(x: (self.carbsView.carbsScrollView.frame.width), y: 0, width: self.carbsView.carbsScrollView.frame.width, height: self.carbsView.carbsScrollView.frame.height)
        self.addChild(carbsTwoVC)
        self.carbsView.carbsScrollView.addSubview(carbsTwoVC.view)
        
        ///StepFourVC Setup
        carbsFourVC = CarbsStepFour.instantiate(fromAppStoryboard: .ReadingEntry)
        carbsFourVC.view.frame = CGRect(x: (self.carbsView.carbsScrollView.frame.width*2), y: 0, width: self.carbsView.carbsScrollView.frame.width, height: self.carbsView.carbsScrollView.frame.height)
        self.addChild(carbsFourVC)
        self.carbsView.carbsScrollView.addSubview(carbsFourVC.view)
        
        ///StepFiveVC Setup
        carbsFiveVC = CarbsStepFive.instantiate(fromAppStoryboard: .ReadingEntry)
        carbsFiveVC.view.frame = CGRect(x: (self.carbsView.carbsScrollView.frame.width*3), y: 0, width: self.carbsView.carbsScrollView.frame.width, height: self.carbsView.carbsScrollView.frame.height)
        self.addChild(carbsFiveVC)
        self.carbsView.carbsScrollView.addSubview(carbsFiveVC.view)
    }
}

// MARK: - UIScrollViewDelegate Delegate
//====================================================
extension CarbsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView.contentOffset.x {
        case 0:
            self.carbsView.navigationBar.stepNumberText = StringConstant.oneByFive.value
        case self.carbsView.frame.width:
            self.carbsView.navigationBar.stepNumberText = StringConstant.twoByFive.value
        case self.carbsView.frame.width*2:
            self.carbsView.navigationBar.stepNumberText = StringConstant.fourByFive.value
            self.carbsView.navigationBar.stepNumberText = StringConstant.fourByFive.value
        case self.carbsView.frame.width*3:
            self.carbsView.navigationBar.stepNumberText = StringConstant.fiveByFive.value
            self.carbsView.setupDoneButton()
        default:
            self.carbsView.navigationBar.stepNumberText = self.carbsView.navigationBar.stepNumberText
        }
    }
}

