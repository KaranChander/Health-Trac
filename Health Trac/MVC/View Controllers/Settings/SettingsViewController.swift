//
//  SettingsViewController.swift
//   Health Track
//


import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
    //======================================================
    @IBOutlet var settingsView: SettingsControllerView!
    
    // MARK: - Variables
    //=======================================================
    var settingsModel: [Int : [SettingsModel]] = [:]
    
    // MARK: - Lifecycle Methods
    //=======================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    // MARK: - Functions
    //================================================
    
    ///Initial setup of VC
    func initialSetup() {
        settingsView.backgroundColor = UIColor(light: .white, dark: .black)
        settingsModel = [0:
                            [SettingsModel(title: StringConstant.darkMode.rawValue, isSwitch: true, isArrow: false, isSubTitle: false, subTitleLabel: "", isSwitchOn: self.darkModeStatus())]]
        settingsView.settingsTableView.allowsSelection = false
        settingsView.settingsTableView.delegate = self
        settingsView.settingsTableView.dataSource = self
        settingsView.settingsTableView.registerCell(with: SettingsCell.self)
        settingsView.settingsTableView.registerCell(with: SettingsSectionHeaderCell.self)
        debugPrint(settingsModel)
    }
    
    ///check DarkMode Status
    func darkModeStatus() -> Bool {
        if let darkMode = AppUserDefaults.value(forKey: .darkModeEnable).bool {
            if darkMode {
                return true
            } else {
                return false
            }
        } else {
            return true
        }
    }
}

// MARK: - TableView Delegate& Datasource
//================================================
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        settingsModel.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueCell(with: SettingsSectionHeaderCell.self)
        headerCell.sectionHeaderLabel.text = section == 0 ? StringConstant.deviceSettings.rawValue : StringConstant.appPreference.rawValue
        return headerCell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let settingsList = settingsModel[section] else {return 0}
        return settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: SettingsCell.self, indexPath: indexPath)
        cell.populateCell(model: settingsModel, indexPath: indexPath)
        cell.darkkModeDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
}

// MARK: - DarkModeToggleDelegate
//================================================
extension SettingsViewController: DarkModeToggleDelegate {
    
    ///Toggles Dark mode from setting VC
    func darkModeToggled(index: IndexPath, isOn: Bool) {
        if settingsModel[index.section]![index.row].title == StringConstant.darkMode.rawValue {
            if isOn {
                UIView.animate(withDuration: 0.5) {
                    self.settingsView.alpha = 0
                    self.settingsModel[index.section]?[index.row].isSwitchOn = true
                } completion: { completed in
                    UIView.animate(withDuration: 0.5) {
                        self.settingsView.alpha = 1
                        if #available(iOS 13.0, *) {
                            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                        } else {
                            // Fallback on earlier versions
                        }
                        AppUserDefaults.save(value: true, forKey: .darkModeEnable)
                    }
                }
                return
            }
            UIView.animate(withDuration: 0.5) {
                self.settingsView.alpha = 0
                self.settingsModel[index.section]?[index.row].isSwitchOn = false
            } completion: { completed in
                UIView.animate(withDuration: 0.5) {
                    self.settingsView.alpha = 1
                    if #available(iOS 13.0, *) {
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                    } else {
                        
                    }
                    AppUserDefaults.save(value: false, forKey: .darkModeEnable)
                }
            }
        }
    }
}
