//
//  ImagePreviewVC.swift
//   Health Track


import UIKit

class ImagePreviewVC: UIViewController {

    // MARK: - IBOutlets
    //======================================================
    @IBOutlet weak var blurBackgroundView: UIVisualEffectView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!

    // MARK: - Variables
    //======================================================
    var previewImage = UIImageView()
    
    // MARK: - View controller life cycle
    //======================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: - Functions
    //======================================================
    
    ///Initial setup of VC
    func initialSetup() {
        setupDismissButton()
        self.previewImageView.image = self.previewImage.image
        self.backImageView.image = #imageLiteral(resourceName: "ic_back")
        self.backImageView.tintColor = UIColor.init(light: .black, dark: .white)
        backImageView.transform = backImageView.transform.rotated(by: -CGFloat(Double.pi/2))
    }
    
    ///Sets up Dismiss Button
    func setupDismissButton() {
        UIView.animate(withDuration: 0.5) {
        }
    }
    
    // MARK: - IBAction
    //======================================================
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
