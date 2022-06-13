//
//  PreferencesWindow.swift
//  RestfulForYou
//
//  Created by priders on 2022/6/6.
//

import Foundation
import AppKit

class PreferencesWindow : NSWindow {
    
    static func addWindow() {
        guard let screen = NSScreen.main else {return}
        let style:NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable, .docModalWindow]
        let rect = NSRect.init(x: 0, y: 0, width: 840, height: 520)
        let win = PreferencesWindow.init(contentRect: rect, styleMask: style, backing: .buffered, defer: true, screen: screen)
        win.level = NSWindow.Level.floating
        win.title = "Preferens"
        win.isReleasedWhenClosed = true
        win.makeKeyAndOrderFront(style)
        win.center()
    }

    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        initUI()
    }
    
    func initUI() {
//        self.contentView?.addSubview(<#T##view: NSView##NSView#>)
    }
    
    
    override func close() {
        ///https://github.com/onmyway133/blog/issues/312
        ///if call NSWindow close will crash
        self.orderOut(NSApp)
    }
    
//    private var

}
