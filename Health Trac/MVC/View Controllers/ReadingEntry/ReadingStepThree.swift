//
//  ReadingStepThree.swift
//   Health Track


import UIKit
import IQKeyboardManagerSwift

class ReadingStepThree: UIViewController {
    
    // MARK: - IBOutlets
    //====================================================
    @IBOutlet var readingStepThreeView: ReadingStepThreeView!
    
    var isDescriptionFilled: Bool = false
    var userDescription: String = ""
    
    // MARK: - View Lifecycle
    //====================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
    }
    
    //MARK: - Functions
    //=================================================
    
    ///Sets up data when registering manual reading
    func nextTapped() {
        isDescriptionFilled = readingStepThreeView.checkDescriptionTextField()
        if isDescriptionFilled {
            self.userDescription = self.readingStepThreeView.descriptionTextView.text
        } else {
            self.userDescription = ""
        }
    }
}
