//
//  DispatchQueueExtension.swift
//   Health Track
//
//

import Foundation
import UIKit

extension DispatchQueue {

    ///Delays the executon of 'closer' block upto a given time
    class func delay(_ delay: Double, closure:@escaping () -> Void) {

        self.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: closure
        )
    }

    ///Returns the main queue asynchronuously
    class func mainQueueAsync(_ closure:@escaping () -> Void) {
        self.main.async(execute: {
            closure()
        })
    }

    ///Returns the main queue synchronuously
    class func mainQueueSync(_ closure:@escaping () -> Void) {
        self.main.sync(execute: {
            closure()
        })
    }

    ///Returns the background queue asynchronuously
    class func backgroundQueueAsync(_ closure:@escaping () -> Void) {
        self.global().async(execute: {
            closure()
        })
    }

    ///Returns the background queue synchronuously
    class func backgroundQueueSync(_ closure:@escaping () -> Void) {
        self.global().sync(execute: {
            closure()
        })
    }
}
