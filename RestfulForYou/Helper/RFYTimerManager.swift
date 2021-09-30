//
//  RFYTimerManager.swift
//  RestfulForYou
//
//  Created by priders on 2021/9/30.
//

import Cocoa

enum TimerStatus {
    case Work
    case Rest
}
//负责处理时间
class RFYTimerManager: NSObject {
    
    static let shared = RFYTimerManager.init()
    
    private var timer: Timer?
    private var countDown:Int = 0
    @objc dynamic private(set) var restCountDown:Int = 0

    private var status:TimerStatus = .Work
    
    private override init() {
        super.init()
    }
    
    @objc func timeOverEvent() {
        switch status {
        case .Work:
            workEvent()
        case .Rest:
            RestEvent()
        }
    }
    
    func workEvent(){
        if countDown <= 0 {
            self.close()
            return
        }
        (NSApp.delegate as? AppDelegate)?.statusItem.button?.title = getTimeString()
        countDown-=1
    }
    
    func RestEvent(){
        if restCountDown <= 0 {
            status = .Work
            RFYCoverManager.shared.start()
        }
        restCountDown-=1
    }

    
    
    func close(){
        RFYCoverManager.shared.stop()
        timer?.invalidate()
        (NSApp.delegate as? AppDelegate)?.statusItem.button?.title = "rest now"
        
        status = .Rest
        startWork(By: 5 * 60 )//设置五分钟休息时间
    }
    
    func open(By time:TimeInterval = 60 * 60) {
        status = .Work
        startWork(By: time)
    }
    
    func startWork(By time:TimeInterval = 60 * 60) {
        timer?.invalidate()
        weak var WSelf = self
        timer = Timer.scheduledTimer(timeInterval: 1, target: WSelf as Any, selector: #selector(timeOverEvent), userInfo: nil, repeats: true)
        guard timer != nil else { return }
        RunLoop.main.add(timer!, forMode: .common)
        countDown = Int(time)
        restCountDown = Int(time)

    }
    
    private func getTimeString() -> String {
        var total:Int = status == .Rest ?  restCountDown : countDown
        let hour = total / 3600
        total = total % 3600
        let min = total / 60
        total = total % 60
        let second = total
        let hourStr = hour > 0 ? "\(String.init(format: "%.2d", hour)):" : ""
        let result = "\(hourStr)\(String.init(format: "%.2d", min)):\(String.init(format: "%.2d", second))"
        print(result)
        return result
    }
    
    func addTime(By minute: Int) {
        countDown+=minute * 60
    }
}
