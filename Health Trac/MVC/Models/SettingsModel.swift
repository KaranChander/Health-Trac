//
//  SettingsModel.swift
//   Health Track


import Foundation

struct SettingsModel {
    var title: String
    var isSwitch: Bool
    var isSwitchOn: Bool = false
    var isArrow: Bool
    var isSubTitle: Bool
    var subTitleLabel: String
    
    init(title: String, isSwitch: Bool, isArrow: Bool, isSubTitle: Bool, subTitleLabel: String, isSwitchOn: Bool = true) {
        self.title = title
        self.isArrow = isArrow
        self.isSwitch = isSwitch
        self.isSubTitle = isSubTitle
        self.subTitleLabel = subTitleLabel
        self.isSwitchOn = isSwitchOn
    }
}
