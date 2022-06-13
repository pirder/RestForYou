//
//  AppDelegate.swift
//  RestfulForYou
//
//  Created by priders on 2021/9/29.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem = NSStatusItem()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        addStatusItem()
        //        NSApp.presentationOptions = [.fullScreen, .hideDock]
        RFYCoverManager.shared.start()
        
    }
    
    fileprivate func addStatusItem() {
        
        let statusBar = NSStatusBar.system
        let statusItem = statusBar.statusItem(withLength: 100)
        let itemImage = NSImage.init(named: "statusItemIcon")
        itemImage?.size = CGSize.init(width: 33, height: 33)
        statusItem.button?.image = itemImage
        statusItem.button?.imagePosition = .imageLeading
        
        
        let subMenu = NSMenu.init(title: "NSMenu1")
        subMenu.addItem(withTitle: "preferences", action: #selector(preferences), keyEquivalent: "")
        subMenu.addItem(withTitle: "Rest Now", action: #selector(statusItemMenuFirst), keyEquivalent: "1")
        subMenu.addItem(withTitle: "add 5 minutes", action: #selector(statusItemMenu2), keyEquivalent: "2")
        subMenu.addItem(withTitle: "add 10 minutes", action: #selector(statusItemMenu3), keyEquivalent: "3")
        subMenu.addItem(withTitle: "add 30 minutes", action: #selector(statusItemMenu4), keyEquivalent: "4")
        subMenu.addItem(withTitle: "add 60 minutes", action: #selector(statusItemMenu5), keyEquivalent: "5")
        subMenu.addItem(withTitle: "reduce 15 minutes", action: #selector(statusItemMenu6), keyEquivalent: "6")
        subMenu.addItem(withTitle: "reduce 5 minutes", action: #selector(statusItemMenu7), keyEquivalent: "7")
        
        subMenu.addItem(withTitle: "Exit", action: #selector(statusItemMenuLast), keyEquivalent: "Q")
        
        statusItem.menu = subMenu
        
        self.statusItem = statusItem
        NSMenu.setMenuBarVisible(false)
        
    }
    
    @objc func statusItemMenuFirst() {
        RFYTimerManager.shared.close()
    }
    
    @objc func statusItemMenu2() {
        RFYTimerManager.shared.addTime(By: 5)
    }
    @objc func statusItemMenu3() {
        RFYTimerManager.shared.addTime(By: 10)
    }
    @objc func statusItemMenu4() {
        RFYTimerManager.shared.addTime(By: 30)
    }
    @objc func statusItemMenu5() {
        RFYTimerManager.shared.addTime(By: 60)
    }
    
    @objc func statusItemMenu6() {
        RFYTimerManager.shared.addTime(By: -15)
    }
    
    @objc func statusItemMenu7() {
        RFYTimerManager.shared.addTime(By: -5)
    }
    
    @objc func preferences() {
        PreferencesWindow.addWindow()
    }
    
    
    @objc func statusItemMenuLast() {
        NSApp.terminate(self)
    }
    
}

