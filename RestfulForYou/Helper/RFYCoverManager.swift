//
//  RFYCoverManager.swift
//  RestfulForYou
//
//  Created by priders on 2021/9/29.
//

import Cocoa
//负责处理UI
class RFYCoverManager: NSObject {
    
    private var windows = [RFYCoverWindow?]()
    
    static let shared = RFYCoverManager()
    
    private override init() {
        super.init()
    }
    
    func stop() {
        var index = 0
        NSScreen.screens.forEach { (screen) in
            if index < windows.count {
                windows[index]?.setFrame(screen.visibleFrame, display: true)
            } else {
                createWindow(screen: screen)
            }
            index+=1
        }
    }
    
    func createWindow(screen:NSScreen) {
        let style = RFYCoverWindow.StyleMask.init(rawValue: 0)
        let win = RFYCoverWindow.init(contentRect: screen.frame, styleMask: style, backing: .buffered, defer: true, screen: screen)
        win.level = NSWindow.Level.floating
        weak var weakSelf = self
        win.makeKeyAndOrderFront(weakSelf)
        win.setFrameOrigin(screen.visibleFrame.origin)
        weak var weakWin = win
        addWindow(window: weakWin)
    }
    
    func start(ByMin min: TimeInterval = 45) {
        windows.forEach({ (win) in
            win?.setFrame(CGRect.init(x: 0, y: 0, width: 0, height: 0), display: false)
        })
        RFYTimerManager.shared.open(By: 60 * min)
    }
    
    private func addWindow(window: RFYCoverWindow?) {
        windows.append(window)
    }
    
    private func removeAllWindows()  {
        windows.removeAll()
    }
}
