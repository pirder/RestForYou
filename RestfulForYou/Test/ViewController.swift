//
//  ViewController.swift
//  RestfulForYou
//
//  Created by priders on 2021/9/29.
//

import Cocoa
import SnapKit

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = NSRect(x: 0, y: 0, width: 0, height: 0)
        self.view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            
        }
        
    }
    
    lazy var closeButton:NSButton = {
        let button = NSButton.init()
        return button
    }()
    
    override var representedObject: Any? {
        didSet {
        }
    }
    
}

