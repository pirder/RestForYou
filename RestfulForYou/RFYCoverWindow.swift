//
//  RFYCoverWindow.swift
//  RestfulForYou
//
//  Created by priders on 2021/9/29.
//

import Cocoa

class RFYCoverWindow: NSWindow {
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        initUI()
    }
    
    
    func initUI(){
        self.contentView?.addSubview(button)
        self.contentView?.addSubview(label)
        
        button.action = #selector(buttonTouchinside)
        button.target = self
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(button.snp.top).offset(-19)
            make.size.equalTo(CGSize(width: 200, height: 20))
        }
        
        weak var WSelf = self
        if let StrongSelf = WSelf {
            RFYTimerManager.shared.addObserver(StrongSelf, forKeyPath: "restCountDown", options: [.new], context: nil)
        }
    }
    
    lazy var button: NSButton = {
        let btn = NSButton() 
        btn.title = "I'm want to work for myself"
        return btn
    }()
    
    lazy var label: NSTextView = {
        let textF = NSTextView.init()
        textF.alignment = .center
        return textF
    }()
    
    @objc func buttonTouchinside(){
        RFYCoverManager.shared.start()
    }
    
    
    func removeObserver(){
        weak var WSelf = self
        if let StrongSelf = WSelf {
            RFYTimerManager.shared.removeObserver(StrongSelf, forKeyPath: "restCountDown")
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "restCountDown" {
            if let str = change?[NSKeyValueChangeKey.newKey] as? Int {
                label.string = "离休息结束 还剩下\(str.getTimeString())"
            }
        }
    }
    
    
}

extension Int {
    func getTimeString() -> String {
        var total:Int = self
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
    
}
