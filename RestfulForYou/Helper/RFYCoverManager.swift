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
        if let img =  NSImage.desktopPictures().first,let image = img {
            win.backgroundImage.image = NSImage.init(cgImage: image, size: NSSize(width: screen.visibleFrame.size.width , height: screen.visibleFrame.size.height))
        }
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

extension NSImage {
    
    static func desktopPictures() -> [CGImage?] {
        
        let info = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as? [[ String : Any]]
        
        var images = [CGImage?]()
        
        for window in info! {
            
            // we need windows named like "Desktop Picture %"
            if let name = window["kCGWindowName"] as? String {
                let key = "Desktop Picture"
                if !name.hasPrefix(key) {
                    continue
                }
                
                // this belongs to a screen
                let index = window["kCGWindowNumber"] as! CGWindowID
                print(CGRect.infinite)
                let cgImage = CGWindowListCreateImage(CGRect.null, CGWindowListOption(arrayLiteral: CGWindowListOption.optionIncludingWindow), index, CGWindowImageOption.nominalResolution)
                images.append(cgImage)
                
            }
        }
        
        // return the array of Desktop images
        return images
    }
    
}
