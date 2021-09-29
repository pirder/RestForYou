//
//  RFYCoverManager.swift
//  RestfulForYou
//
//  Created by priders on 2021/9/29.
//

import Cocoa

class RFYCoverManager: NSObject {
    
    private var windows = [RFYCoverWindow?]()
    
    static let shared = RFYCoverManager()
    
    private override init() {
        super.init()
    }
    
    func startWorking() {
        NSScreen.screens.forEach { (screen) in
            let style = RFYCoverWindow.StyleMask.init(rawValue: 0)
            let win = RFYCoverWindow.init(contentRect: screen.frame, styleMask: style, backing: .buffered, defer: true, screen: screen)
//            win.level = NSWindow.Level(rawValue: 21)
            win.makeKeyAndOrderFront(self)
            win.setFrameOrigin(screen.visibleFrame.origin)
            weak var weakWin = win
            addWindow(window: weakWin)
            printWindows()
        }
    }
    
    func stopWork() {
        windows.forEach({ (win) in
            win?.close()
        })
    }
    
    func printWindows() {
        print(windows)
    }



    private func addWindow(window: RFYCoverWindow?) {
        windows.append(window)
    }
    
    private func removeAllWindows()  {
        windows.removeAll()
    }
}
