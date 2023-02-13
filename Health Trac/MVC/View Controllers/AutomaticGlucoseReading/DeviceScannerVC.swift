//
//  AutomaticGlucoseReadingVC.swift
//   Health Track

import UIKit
import CoreBluetooth


class DeviceScannerVC: UIViewController {
    
    // MARK: - IBOutlets
    //======================================================
    @IBOutlet var automaticGlucoseReadingView: DeviceScannerView!
    
    // MARK: - Variables
    //======================================================
    var centralManager: CBCentralManager?
    private var discoveredPeripherals = [DiscoveredPeripheral]()
    
    
    // MARK: - View Controller life cycle
    //======================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Functions
    //======================================================
    
    ///Initial setup of VC
    func initialSetup() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
        actions()
        registerXibs()
        automaticGlucoseReadingView.bluetoothDevicesTableView.delegate = self
        automaticGlucoseReadingView.bluetoothDevicesTableView.dataSource = self
    }
    
    ///Handles IBActions of the View
    func actions() {
        
        //Handling ManualGlucose Button Tap
        self.automaticGlucoseReadingView.manualGlucoseBtnTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            let scene = ReadingViewController.instantiate(fromAppStoryboard: .ReadingEntry)
            self.centralManager?.stopScan()
            self.navigationController?.pushViewController(scene, animated: true)
        }
        
        //Handling Back Button Tap
        self.automaticGlucoseReadingView.navigationBarContainer.backButtonTapped = {[weak self] (button) in
            guard let `self` = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
            self.centralManager?.stopScan()
            NotificationCenter.default.post(name: NSNotification.Name(StringConstant.hidePopUp.value), object: nil)
            }
    }
    
    ///Registers required xib files
    func registerXibs() {
        automaticGlucoseReadingView.bluetoothDevicesTableView.registerCell(with: ScannerTableViewCell.self)
    }
    
}

// MARK: - Table View Delegates
//======================================================
extension DeviceScannerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveredPeripherals.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: ScannerTableViewCell.self, indexPath: indexPath)
        cell.deviceLabel.text = discoveredPeripherals[indexPath.row].advertisedName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        centralManager?.stopScan()
        centralManager?.connect(discoveredPeripherals[indexPath.row].basePeripheral)
    }
}


// MARK: - CBCentralManager Delegates
//======================================================
extension DeviceScannerVC: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
        case .unknown:
            printDebug("central.state is .unknown")
        case .resetting:
            printDebug("central.state is .resetting")
        case .unsupported:
            printDebug("central.state is .unsupported")
        case .unauthorized:
            printDebug("central.state is .unauthorized")
        case .poweredOff:
            printDebug("central.state is .poweredOff")
            
        case .poweredOn:
            printDebug("central.state is .poweredOn")
            // MARK: - 2) Start scanning for Peripherals
            // Here we specifically looking for peripherals with Heart Rate service
            // We can change the UUID to look for peripherals with other services
            // Or we can set it to nil and get all peripherals around
            // This will call didDiscover delegate method
            centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    // MARK: - 3) Here we get a reference to the peripheral
    // Now we stop scanning other for other peripherals
    // And connect to heartRatePeripheral
    // This will call didConnect delegate method
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        printDebug(peripheral)
        var discoveredPeripheral = discoveredPeripherals.first(where: { $0.basePeripheral.identifier == peripheral.identifier })
        if discoveredPeripheral == nil {
            discoveredPeripheral = DiscoveredPeripheral(peripheral)
            if let peripheral = discoveredPeripheral {
                if ((advertisementData[CBAdvertisementDataLocalNameKey] as? String) != nil) {
                discoveredPeripherals.append(peripheral)
                peripheral.update(withAdvertisementData: advertisementData, andRSSI: RSSI)
                }
            }
        }
        
        // Update the object with new values.
        self.automaticGlucoseReadingView.bluetoothDevicesTableView.reloadData()

    }
    
    // MARK: - 4) Here the iOS device as a central and the Hart Rate sensor as a peripheral are connected
    // Now we dicover the Heart Rate Service in the Peripheral
    // We can discover all available services by setting the array to nil
    // This will call didDiscoverServices delegate method
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        let scene = AutomaticGlucoseReadingVC.instantiate(fromAppStoryboard: .ExerciseEntryStepTwo)
        scene.glucoseReaderPeripheral = peripheral
        scene.centralManager = self.centralManager
        self.navigationController?.pushViewController(scene, animated: true)
    }
}
