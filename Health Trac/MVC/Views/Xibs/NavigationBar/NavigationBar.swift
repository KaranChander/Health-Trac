//
//  NavigationBar.swift
//   Health Track

import UIKit

/// This is the Custom Class for Navigation Bar
final class NavigationBar: UIView {
    
    // MARK: - Static Variable
    //======================================================
    private static let NIB_NAME = "NavigationBar"
    
    // MARK: - IBOutlets
    //======================================================
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    // MARK: - Variables
    //======================================================
    var backButtonTapped: ((UIButton)->Void)?
    var myMutableString: NSMutableAttributedString?
    var stepNumberText: String = "" {
        didSet {
            initialSetup()
        }
    }

    // MARK: - Functions
    //======================================================
    override func awakeFromNib() {
        initWithNib()
        initialSetup()
    }
    
    ///Private function to initialise nib
    private func initWithNib() {
        Bundle.main.loadNibNamed(NavigationBar.NIB_NAME, owner: self, options: nil)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(baseView)
        setupLayout()
    }
    
    ///Initial setup of class
    func initialSetup() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.setupColor()
            self.setupFont()
            self.rightLabel.attributedText = self.myMutableString
        }
    }
    
    ///Setting up font
    func setupFont() {
        rightLabel.font = AppFonts.Montserrat_Light.withSize(25)
        if stepNumberText.count >= 2 {
            self.myMutableString = NSMutableAttributedString(string: self.stepNumberText as String, attributes: [NSAttributedString.Key.font: AppFonts.Montserrat_Light.withSize(25) ])
            self.myMutableString?.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(light: AppColors.lightGray , dark: AppColors.white.withAlphaComponent(0.5)), range: NSRange(location:2,length:2))
        }
    }
    
    ///Setting up color
    func setupColor() {
        arrowImage.tintColor = UIColor(light: AppColors.black, dark: AppColors.white)
        baseView.backgroundColor = UIColor(light: AppColors.clear, dark: AppColors.clear)
    }
    
    ///Setup Layout
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                baseView.topAnchor.constraint(equalTo: topAnchor),
                baseView.leadingAnchor.constraint(equalTo: leadingAnchor),
                baseView.bottomAnchor.constraint(equalTo: bottomAnchor),
                baseView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
    }
    
    // MARK: - IBActions
    //======================================================
    @IBAction func backButtonTapped(_ sender: UIButton) {
        if let handler = self.backButtonTapped {
            handler(sender)
        }
    }
}
