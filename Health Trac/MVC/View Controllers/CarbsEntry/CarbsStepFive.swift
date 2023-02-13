//
//  CarbsStepFive.swift
//   Health Track


import UIKit

class CarbsStepFive: UIViewController {
    
    //MARK: - IBOutlets
    //=================================================
    @IBOutlet var carbsStepFiveView: CarbsStepFiveView!
    
    //MARK: - View LifeCycles
    //=================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.carbsStepFiveView.stepFiveScrollView.contentSize = CGSize(width: self.carbsStepFiveView.frame.width, height: 5750)
        self.carbsStepFiveView.imagePreviewBtnTapped = { [weak self] (button) in
            guard let `self` = self else { return }
            let scene = ImagePreviewVC.instantiate(fromAppStoryboard: .ReadingEntry)
            scene.previewImage.image = self.carbsStepFiveView.carbsImage.image
            self.present(scene, animated: true, completion: nil)
        }
    }
    
    //MARK: - Functions
    //=================================================
    
    ///Sets up data when registering manual reading
    func setupViewWithData(model: ReadingsModel) {
        let any = model.createdAt.split(separator: "-")
        self.carbsStepFiveView.dateLabelText = String(any[0])
        self.carbsStepFiveView.timeLabelText = String(any[1])
        self.carbsStepFiveView.carbsLabelText = "\(String(model.carbsReading)) Grams"
        self.carbsStepFiveView.userDescriptionText = model.userDescription
        if model.userDescription.isEmpty {
            carbsStepFiveView.descriptionHeadLabel.isHidden = true
        } else {
            carbsStepFiveView.descriptionHeadLabel.isHidden = false
        }
        if model.carbsMedia == "" {
            carbsStepFiveView.imagesViewHeight.constant = 0
            carbsStepFiveView.imageBaseView.isHidden = true
        }
        guard let media = self.loadImageFromPath(model.carbsMedia as NSString) else {return}
        self.carbsStepFiveView.imageMedia = media
        self.carbsStepFiveView.setupLabelText()
    }
    
    ///Sets up data when comming from activityVC
    func setupViewWithData(model: ReadingsDetail) {
        let any = model.createdAt.split(separator: "-")
        self.carbsStepFiveView.dateLabelText = String(any[0])
        self.carbsStepFiveView.timeLabelText = String(any[1])
        self.carbsStepFiveView.carbsLabelText = "\(String(model.carbsReading)) Grams"
        self.carbsStepFiveView.userDescriptionText = model.userDescription
        if model.userDescription.isEmpty {
            carbsStepFiveView.descriptionHeadLabel.isHidden = true
        } else {
            carbsStepFiveView.descriptionHeadLabel.isHidden = false
        }
        if model.carbsMedia == "" {
            carbsStepFiveView.imagesViewHeight.constant = 0
            carbsStepFiveView.imageBaseView.isHidden = true
        }
        guard let media = self.loadImageFromPath(model.carbsMedia as NSString) else {return}
        self.carbsStepFiveView.imageMedia = media
        self.carbsStepFiveView.setupLabelText()
    }
    
    ///Loads Image from Url Path
    func loadImageFromPath(_ path: NSString) -> UIImage? {
        let image = UIImage(contentsOfFile: path as String)
        guard let media = image else {return UIImage()}
        guard let cgMedia = media.cgImage else {return media}
        let newMedia = UIImage(cgImage: cgMedia, scale: media.scale, orientation: .up)
        return newMedia
    }
}
