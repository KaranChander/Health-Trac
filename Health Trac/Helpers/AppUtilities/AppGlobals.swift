//
//  Globals.swift
//  Onboarding
//  Health Track


import Foundation
import UIKit

/// Print Debug
func printDebug<T>(_ obj: T) {
    #if DEBUG
        print(obj)
    #endif
}

/// Is Simulator or Device
var isSimulatorDevice: Bool {

    var isSimulator = false
    #if arch(i386) || arch(x86_64)
        //simulator
        isSimulator = true
    #endif
    return isSimulator
}

/// Is this iPhone X or not
func isDeviceIsIphoneX() -> Bool {
    let device: UIDevice = UIDevice()
    if device.userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136: return false
        case 1334: return false
        case 2208: return false
        case 2436: return true
        default: return false
        }
    }
    return false
}

///checking Iphone model to set navigation bar bounds
func checkIsIphoneXOrGreater() -> Bool {
  if UIDevice.hasNotch {
        return true
  } else {
    return false
  }
}

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places)) //10
        let newDecimal = multiplier * self // move the decimal right  10*120.160 = 1201.60
        let truncated = Double(Int(newDecimal)) // drop the fraction   1201.0
        let originalDecimal = truncated / multiplier // move the decimal back 120.1
        return originalDecimal
    }
}

