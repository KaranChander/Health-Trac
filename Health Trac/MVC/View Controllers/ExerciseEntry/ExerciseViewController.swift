//
//  ExerciseViewController.swift
//   Health Track

import UIKit

class ExerciseViewController: UIViewController {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var exerciseView: ExerciseView!
    
    // MARK: - Variables
    //====================================================
    private var exerciseOneVC: ExerciseStepOne!
    private var exerciseTwoVC: ExerciseStepTwo!
    private var exerciseThreeVC: ExerciseStepThree!
    private var exerciseFourVC: ExerciseStepFour!
    var model = ReadingsModel()
    var isComingFromActivityTab: Bool = false
    var detailModel = ReadingsDetail()
    
    // MARK: - ViewLifeCycle
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.exerciseView.exrciseScrollView.delegate = self
        setupSubviews()
        actions()
        fromActivityTab()
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Handles when user taps exercise cell in activity tab
    func fromActivityTab() {
        if isComingFromActivityTab {
            self.exerciseView.exrciseScrollView.setContentOffset(CGPoint(x:self.exerciseView.width*3 , y: 0), animated: false)
            self.exerciseView.navigationBar.rightLabel.isHidden = true
            self.exerciseView.nextLabel.isHidden = true
            self.exerciseView.nextImage.isHidden = true
            self.exerciseView.nextButton.isHidden = true
            self.exerciseFourVC.setupViewWithData(model: detailModel)
        }
    }
    
    ///Handles IBActions from the view
    func actions() {
        
        //Handling Next Button Tap
        self.exerciseView.nextButtonTapped = { [weak self] (button) in
            guard let `self` = self else { return }
            switch self.exerciseView.exrciseScrollView.contentOffset.x {
                
                ///STEP ONE EXERCISE READING
            case 0:
                self.exerciseOneVC.nextTapped()
                self.model.id = ReadingsDetail.createId() ?? 1
                self.model.createdAt = self.exerciseOneVC.createdAt
                self.model.createdDateString = self.exerciseOneVC.createdDateString
                self.model.readingType = self.exerciseOneVC.readingType
                self.exerciseTwoVC.exerciseStepTwoView.pickerLeadingConstraint.constant = -9
                DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
                    self.exerciseTwoVC.exerciseStepTwoView.setupDatePicker()
                }
                self.exerciseView.exrciseScrollView.setContentOffset(CGPoint(x:self.exerciseView.width , y: 0), animated: true)
                
                
                ///STEP TWO EXERCISE READING
            case self.exerciseView.width:
                self.exerciseTwoVC.nextTapped()
                self.model.exerciseReading.hours = self.exerciseTwoVC.exerciseHours
                self.model.exerciseReading.minutes = self.exerciseTwoVC.exerciseMins
                self.exerciseView.exrciseScrollView.setContentOffset(CGPoint(x:self.exerciseView.width*2 , y: 0), animated: true)
                
                ///STEP THREE EXERCISE READING
            case self.exerciseView.width*2:
                self.exerciseThreeVC.nextTapped()
                self.model.userDescription = self.exerciseThreeVC.userDescription
                self.exerciseView.exrciseScrollView.setContentOffset(CGPoint(x:self.exerciseView.width*3 , y: 0), animated: true)
                self.exerciseFourVC.setupViewWithData(model: self.model)
                
                ///STEP FOUR EXERCISE READING
            case self.exerciseView.width*3:
                self.navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: Notification.Name(StringConstant.hidePopUp.value), object: nil)
                ReadingsDetail.saveReadingData(readingsModel: self.model)
                NotificationCenter.default.post(name: NSNotification.Name(StringConstant.updateLogBook.value), object: nil)
                
            default:
                self.exerciseView.exrciseScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }
        
        //Handling Back Button Tap
        self.exerciseView.navigationBar.backButtonTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            switch self.exerciseView.exrciseScrollView.contentOffset.x {
                
                ///STEP ONE EXERCISE READING
            case 0:
                self.navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: NSNotification.Name(StringConstant.hidePopUp.value), object: nil)
                
                ///STEP TWO EXERCISE READING
            case self.exerciseView.frame.width:
                self.exerciseView.setupNextButton()
                self.exerciseTwoVC.exerciseStepTwoView.pickerLeadingConstraint.constant = 0
                self.exerciseView.exrciseScrollView.setContentOffset(CGPoint(x:0 , y: 0), animated: true)
                
                ///STEP THREE EXERCISE READING
            case self.exerciseView.frame.width*2:
                self.exerciseView.setupNextButton()
                self.exerciseView.exrciseScrollView.setContentOffset(CGPoint(x:self.exerciseView.width , y: 0), animated: true)
                
                ///STEP FOUR EXERCISE READING
            case self.exerciseView.frame.width*3:
                if self.isComingFromActivityTab {
                    self.navigationController?.popViewController(animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        NotificationCenter.default.post(name: NSNotification.Name(StringConstant.comingFromActivity.value), object: nil)
                    }
                } else {
                    self.exerciseView.setupNextButton()
                    self.exerciseView.exrciseScrollView.setContentOffset(CGPoint(x:self.exerciseView.width*2 , y: 0), animated: true)
                }
                
            default:
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    ///Sets Up subviews on scrolllView
    func setupSubviews() {
        self.exerciseView.layoutSubviews()
        self.exerciseView.layoutIfNeeded()
        self.exerciseView.exrciseScrollView.layoutIfNeeded()
        self.exerciseView.exrciseScrollView.isPagingEnabled = true
        self.exerciseView.exrciseScrollView.frame.size = CGSize(width: self.exerciseView.width, height: self.exerciseView.exrciseScrollView.height)
        self.exerciseView.exrciseScrollView.contentSize = CGSize(width: self.exerciseView.width*4, height: self.exerciseView.exrciseScrollView.height)
        
        ///StepOneVC Setup
        exerciseOneVC = ExerciseStepOne.instantiate(fromAppStoryboard: .ReadingEntry)
        exerciseOneVC.view.frame = CGRect(x: 0, y: 0, width: self.exerciseView.exrciseScrollView.frame.width, height: self.exerciseView.exrciseScrollView.frame.height)
        self.addChild(exerciseOneVC)
        self.exerciseView.exrciseScrollView.addSubview(exerciseOneVC.view)
        
        ///StepTwoVC Setup
        exerciseTwoVC = ExerciseStepTwo.instantiate(fromAppStoryboard: .ReadingEntry)
        exerciseTwoVC.view.frame = CGRect(x: (self.exerciseView.exrciseScrollView.frame.width), y: 0, width: self.exerciseView.exrciseScrollView.frame.width, height: self.exerciseView.exrciseScrollView.frame.height)
        self.addChild(exerciseTwoVC)
        self.exerciseView.exrciseScrollView.addSubview(exerciseTwoVC.view)
        
        ///StepThreeVC Setup
        exerciseThreeVC = ExerciseStepThree.instantiate(fromAppStoryboard: .ReadingEntry)
        exerciseThreeVC.view.frame = CGRect(x: (self.exerciseView.exrciseScrollView.frame.width*2), y: 0, width: self.exerciseView.exrciseScrollView.frame.width, height: self.exerciseView.exrciseScrollView.frame.height)
        self.addChild(exerciseThreeVC)
        self.exerciseView.exrciseScrollView.addSubview(exerciseThreeVC.view)
        
        ///StepFourVC Setup
        exerciseFourVC = ExerciseStepFour.instantiate(fromAppStoryboard: .ReadingEntry)
        exerciseFourVC.view.frame = CGRect(x: (self.exerciseView.exrciseScrollView.frame.width*3), y: 0, width: self.exerciseView.exrciseScrollView.frame.width, height: self.exerciseView.exrciseScrollView.frame.height)
        self.addChild(exerciseFourVC)
        self.exerciseView.exrciseScrollView.addSubview(exerciseFourVC.view)
    }
}

// MARK: - UIScrollViewDelegate Delegate
//====================================================
extension ExerciseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView.contentOffset.x {
        case 0:
            self.exerciseView.navigationBar.stepNumberText = StringConstant.oneByFour.value
        case self.exerciseView.frame.width:
            self.exerciseView.navigationBar.stepNumberText = StringConstant.twoByFour.value
        case self.exerciseView.frame.width*2:
            self.exerciseView.navigationBar.stepNumberText = StringConstant.threeByFour.value
        case self.exerciseView.frame.width*3:
            self.exerciseView.navigationBar.stepNumberText = StringConstant.fourByFour.value
            self.exerciseView.setupDoneButton()
        default:
            self.exerciseView.navigationBar.stepNumberText = self.exerciseView.navigationBar.stepNumberText
        }
    }
}
