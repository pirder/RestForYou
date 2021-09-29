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
        RFYTimerManager.shared
//        NSApp.presentationOptions = [.fullScreen, .hideDock]
        RFYCoverManager.shared.startWorking()

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    fileprivate func addStatusItem() {
        // Insert code here to initialize your application
        let statusBar = NSStatusBar.system
        let statusItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        statusItem.highlightMode = true
        let itemImage = NSImage.init(named: "statusItemIcon")
        itemImage?.size = CGSize.init(width: 33, height: 33)
        statusItem.image = itemImage
        let subMenu = NSMenu.init(title: "NSMenu1")
        subMenu.addItem(withTitle: "CloseWindows", action: #selector(statusItemMenuFirst), keyEquivalent: "R")
        subMenu.addItem(withTitle: "Print", action: #selector(statusItemMenuSecond), keyEquivalent: "Q")
        subMenu.addItem(withTitle: "Exit", action: #selector(statusItemMenuLast), keyEquivalent: "E")

        statusItem.menu = subMenu
        
        self.statusItem = statusItem
        NSMenu.setMenuBarVisible(false)

    }
    
    @objc func statusItemMenuFirst() {
        RFYCoverManager.shared.stopWork()
    }
    
    @objc func statusItemMenuSecond() {
        RFYCoverManager.shared.startWorking()
    }

    @objc func statusItemMenuLast() {
        NSApp.terminate(self)
    }

}

