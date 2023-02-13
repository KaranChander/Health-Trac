//
//  AutomaticGlucoseReadingVC.swift
//   Health Track


import UIKit
import CoreBluetooth

class AutomaticGlucoseReadingVC: UIViewController {
    
    // MARK: - IBOutlets
    //================================================================================
    @IBOutlet var automaticGlucoseReadingView: AutomaticGlucoseReadingView!
    
    // MARK: - Variables
    //================================================================================
    var centralManager: CBCentralManager!
    var glucoseReaderPeripheral: CBPeripheral!
    let gbsDeviceServiceSecond = CBUUID.init(string: "75C276C3-8F97-20BC-A143-B354244886D4")
    var glucoseReadingModel = AutomaticGlucoseReading()
    var model = ReadingsModel()

    // MARK: - View Controller Life Cycle
    //================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    // MARK: - Functions
    //================================================================================
    
    ///Initial setup of VC
    func initialSetup() {
        actions()
        glucoseReaderPeripheral.delegate = self
        glucoseReaderPeripheral.discoverServices([gbsDeviceServiceSecond])
    }
    
    ///Handles IBActions of the View
    func actions() {
        
        //Handling ManualGlucose Button Tap
        self.automaticGlucoseReadingView.manualGlucoseButtonTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            let scene = ReadingViewController.instantiate(fromAppStoryboard: .ReadingEntry)
            self.centralManager.cancelPeripheralConnection(self.glucoseReaderPeripheral)
            self.navigationController?.pushViewController(scene, animated: true)
        }
        
        //Handling Back Button Tap
        self.automaticGlucoseReadingView.navigationBarView.backButtonTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.centralManager.cancelPeripheralConnection(self.glucoseReaderPeripheral)
            self.pop()
        }
    }
    
    ///Setting up glucose model
    func setupGlucoseModel() {
        self.model.id = ReadingsDetail.createId() ?? 1
        let date = self.formatDate(date: Date())
        self.model.createdAt = "\(date) - \(CommonFunctions.converTo12(hour: Date().localDate().hour)):\(String(format: "%02d", (Date().localDate().minute))) \(self.getMeridiemfrom(date: Date()))"
        self.model.readingType = ReadingsType.glucose.rawValue
        self.goToReadingsVC()
    }
    
    ///Formatting Date function
    func formatDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
    
    ///function to get meridiem
    func getMeridiemfrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        return dateFormatter.string(from: date)
    }
    
    ///function to go to readingVC
    func goToReadingsVC() {
        let scene = ReadingViewController.instantiate(fromAppStoryboard: .ReadingEntry)
        scene.model = self.model
        scene.isComingFromAutomaticGlucoseReading = true
        self.navigationController?.pushViewController(scene, animated: true)
    }
}

// MARK: - CBPeripheral Delegate functions
//=========================================================================================================
extension AutomaticGlucoseReadingVC: CBPeripheralDelegate {
    
    // MARK: - 5) Here we get an array that has one element which is Hate Rate service
    // Now we discover all characteristics in the Hate Rate service
    // This will call didDiscoverCharacteristicsFor delegate method
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        guard let services = peripheral.services else { return }
        
        for service in services {
            printDebug(service)
            print(service.characteristics ?? "characteristics are nil")
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    
    // MARK: - 6) Here we get 2 Characteristics:
    // 1. Body Location Characteristic: has read property for one time read
    // 2. Heart Rate Measurement Characteristic: has notify property, to notify the iOS device every time the hart rate changes
    // This will update didUpdateValueFor delegate method
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            
            if characteristic.properties.contains(.read) {
              print("\(characteristic.uuid): properties contains .read")
              peripheral.readValue(for: characteristic)
            }
            if characteristic.properties.contains(.notify) {
                printDebug("\(characteristic.uuid): properties contains .notify")
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    
    // MARK: - 7) Here we get the value of the Body Location one time & the value of Heart Rate every notification
    // So we read the characteristic value and show it on the corresponding Label
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        var asciiValue = ""
        if let characteristicValue = characteristic.value {
            asciiValue = String(data: characteristicValue, encoding: .ascii) ?? ""
        }

            switch asciiValue.first {
            case "0":
                printDebug("Idle State")
            case "1":
                printDebug("strip insert state")
                UIView.animate(withDuration: 2) {
                    self.automaticGlucoseReadingView.stripContainerView.transform = CGAffineTransform.init(translationX: 0, y: -80)
                }
            case "2":
                printDebug("Processing data state")
                self.automaticGlucoseReadingView.processingView.isHidden = false
                self.automaticGlucoseReadingView.animateCircle()
            case "3":
                printDebug("Reading state")

                let readingValue = asciiValue.components(separatedBy: ",")
                printDebug(readingValue)
                if readingValue.count == 3 {
                    self.model.glucoseReading = Double(readingValue[2]) ?? 0.0
                    switch readingValue[1] {
                    case "1":
                        self.model.glucoseUnit = GlucoseUnits.mmol.rawValue
                        if self.model.glucoseReading < 2.8 {
                            self.model.glucoseReadingType = glucoseReadingsType.saliva.rawValue
                        } else {
                            self.model.glucoseReadingType = glucoseReadingsType.blood.rawValue
                        }
                        
                    case "2":
                        self.model.glucoseUnit = GlucoseUnits.mgdl.rawValue
                        if self.model.glucoseReading < 50 {
                            self.model.glucoseReadingType = glucoseReadingsType.saliva.rawValue
                        } else {
                            self.model.glucoseReadingType = glucoseReadingsType.blood.rawValue
                        }
                    default:
                        break
                    }
                    
                    
                    centralManager.cancelPeripheralConnection(self.glucoseReaderPeripheral)
                    CommonFunctions.showToastWithMessage(StringConstant.readingReceived.value)
                    self.setupGlucoseModel()
                    }
            default:
                break
                }
        }
}
