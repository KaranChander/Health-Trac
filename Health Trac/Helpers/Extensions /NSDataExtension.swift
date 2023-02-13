//
//  NSDataExtension.swift
//   Health Track
//
//  Created by Karan on 10/11/21.
//

import Foundation

extension NSData {
    
    /// Hexadecimal string representation of `Data` object.
    
    var hexadecimal: String {
        return map { String(format: "%02x", $0) }
            .joined()
    }
}
