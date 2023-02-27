//
//  ActivityReadingCell.swift
//  Health Track


import UIKit

class ActivityReadingCell: UITableViewCell {
    
    // MARK: - IBOutlets
    //================================================
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var sideBarView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - TableView life cycle
    //================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }
    
    // MARK: - Functions
    //================================================
    
    ///Initial setup of xib
    func initialSetup() {
        setupFonts()
        setupColors()
        setupBorders()
        
    }
    
    ///Border setup
    func setupBorders() {
        cardView.round(radius: 15)
        sideBarView.round(radius: 4)
    }
    
    ///Font setup
    func setupFonts() {
        titleLabel.font = AppFonts.Montserrat_Regular.withSize(15)
        descriptionLabel.font = AppFonts.Montserrat_Light.withSize(17)
        timeLabel.font = AppFonts.Montserrat_Medium.withSize(18)
    }
    
    ///Color setup
    func setupColors() {
        cardView.backgroundColor = UIColor.init(light: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.03), dark: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.08273564553))
        descriptionLabel.textColor = UIColor.init(light: .black, dark: .white)
        timeLabel.textColor = UIColor.init(light: .black, dark: .white)
        sideBarView.backgroundColor = AppColors.pinkishOrange
        titleLabel.textColor = AppColors.pinkishOrange
    }
    
    ///Function to populate settings custom cell
    func populateCell(model: ReadingsDetail, latest: Bool) {
        self.timeLabel.text = String(format: "%01d:%02d", CommonFunctions.converTo12(hour: model.createdDate.hour), model.createdDate.minute)
        switch model.readingType {
        
        ///READING TYPE - CARBS
        case ReadingsType.carbs.rawValue:
            self.titleLabel.text = StringConstant.carbohydrates.value
            self.titleLabel.textColor = AppColors.heliotrope
            sideBarView.backgroundColor = AppColors.heliotrope
            self.descriptionLabel.text = "\(model.userDescription)"
            
        ///READING TYPE - EXERCISE
        case ReadingsType.exercise.rawValue:
            let toTime = (model.createdAt.addTime(hours: model.exerciseReading?.hours ?? 0, min: model.exerciseReading?.minutes ?? 0, isMeridiemNeeded: false))
            self.timeLabel.text = "\(String(format: "%01d:%02d", CommonFunctions.converTo12(hour: model.createdDate.hour), model.createdDate.minute)) - \(toTime)"
            self.titleLabel.text = StringConstant.exercise.value
            self.titleLabel.textColor = AppColors.aquaMarine
            sideBarView.backgroundColor = AppColors.aquaMarine
            self.descriptionLabel.text = "\(model.userDescription)"
            
        ///READING TYPE - GLUCOSE
        case ReadingsType.glucose.rawValue:
            self.titleLabel.text = latest ? "Latest Glucose \(StringConstant.reading.value)" : "Glucose \(StringConstant.reading.value)"
            self.titleLabel.textColor = AppColors.pinkishOrange
            sideBarView.backgroundColor = AppColors.pinkishOrange
            if model.userDescription == "" {
                self.descriptionLabel.text = "\(model.glucoseReading) \(model.glucoseUnit) "
            } else {
                self.descriptionLabel.text = "\(model.glucoseReading) \(model.glucoseUnit) - \(model.userDescription)"
            }
            
        default:
            break
        }
    }
    
}
