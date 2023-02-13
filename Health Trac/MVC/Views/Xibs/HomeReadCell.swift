//
//  DataCell.swift
//   Health Track


import UIKit

/// This is the Custom Collection view cell for Home Reading in HomeVC 
class HomeReadCell: UICollectionViewCell {

    // MARK: - IBOutlets
    //====================================================
    @IBOutlet weak var dataNumericLabel: UILabel!
    @IBOutlet weak var dataUnitLabel: UILabel!
    
    // MARK: - Cell Lifecycle
    //====================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    // MARK: - Functions
    //====================================================
    
    ///Initial setup for xib
    func initialSetup() {
        setupFont()
        setupColor()
    }
    
    ///Font setup
    func setupFont() {
        dataNumericLabel.font = AppFonts.Montserrat_Medium.withSize(112)
        dataUnitLabel.font = AppFonts.Montserrat_Medium.withSize(20)
        dataNumericLabel.addCharacterSpacing(of: 0.8)
    }
    
    ///Color setup
    func setupColor() {
        dataNumericLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
        dataUnitLabel.textColor = UIColor(light: AppColors.black, dark: AppColors.white)
    }
    
    ///Function for population homeReading custom Cell
    func populateCell(model: GlucoseReading, row: Int) {
        self.dataUnitLabel.text = model.glucoseUnit
        if row < 2 {
            if model.glucoseUnit == GlucoseUnits.mmol.rawValue {
                self.dataNumericLabel.text = "\(String(format: "%.1f", model.glucoseReading))"
            } else {
                self.dataNumericLabel.text = "\(String(format: "%.0f", model.glucoseReading))"
            }
        } else {
            if model.glucoseUnit == GlucoseUnits.mmol.rawValue {
                self.dataNumericLabel.text = "\(String(format: "%.2f", model.glucoseReading))"
            } else {
                self.dataNumericLabel.text = "\(String(format: "%.1f", model.glucoseReading))"
            }
        }
    }
    
    ///Function for setting up empty cell
    func setupEmptyCell() {
        self.dataNumericLabel.text = "--"
        self.dataUnitLabel.text = GlucoseUnits.mmol.rawValue
    }
}
