//
//  RFYTimerManager.swift
//  RestfulForYou
//
//  Created by priders on 2021/9/30.
//

import Cocoa

class RFYTimerManager: NSObject {
    
    static let shared = RFYTimerManager.init()
    
    private var timer: Timer?
    
    private override init() {
        super.init()
        weak var WSelf = self
        timer = Timer.scheduledTimer(timeInterval: 5, target: WSelf as Any, selector: #selector(timeOverEvent), userInfo: nil, repeats: true)
        
    }
    
    @objc func timeOverEvent() {
        print("timeOverEvent")
        RFYCoverManager.shared.startWorking()
        timer?.invalidate()
        
    }
    
    func startWork(By time:TimeInterval = 2) {
        timer?.invalidate()
        weak var WSelf = self
        timer = Timer.scheduledTimer(timeInterval: time, target: WSelf as Any, selector: #selector(timeOverEvent), userInfo: nil, repeats: true)
        print(timer as Any)
    }
    
}
