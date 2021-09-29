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
        button.action = #selector(buttonTouchinside)
        button.target = self
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    lazy var button: NSButton = {
        let btn = NSButton()
        return btn
    }()
    
    @objc func buttonTouchinside(){
        RFYCoverManager.shared.stopWork()
    }
}
