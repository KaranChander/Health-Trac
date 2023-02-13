//
//  TrueTimeManager.swift
//   Health Track
//


import Foundation
import TrueTime

class TrueTimeManager {
    
    public var currentTime: Date {
        if let safeReferencetime = referenceTime {
            return safeReferencetime.now()
        }
        return Date()
    }
    
    fileprivate var referenceTime: ReferenceTime?
    fileprivate var timer: Timer?
    
    static let _shared = TrueTimeManager()
    
    static var shared: TrueTimeManager {
        return ._shared
    }
    
    private init() { }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Start the timer
    public func startTrueTime() {
        TrueTimeClient.sharedInstance.start()
        self.refreshReferenceTime()
        //self.registerApplicationStatusNotification()
    }
    
    public func refreshReferenceTime() {
        TrueTimeClient.sharedInstance.fetchIfNeeded { result in
            switch result {
            case let .success(referenceTime):
                self.referenceTime = referenceTime
                printDebug("Got network time! \(referenceTime)")
            case let .failure(error):
                printDebug("Error! \(error)")
            }
        }
    }
    
    private func registerApplicationStatusNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(startTimer),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cancelTimer),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
    
    @objc func startTimer() {
        self.refreshReferenceTime()
        timer = .scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }
    
    @objc func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func tick() {
        if let referenceTime = referenceTime {
            let trueTime = referenceTime.now()
            printDebug(trueTime)
        }
    }
    
}
