//
//  MainWindowController.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/10/6.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet weak var mainWindow: NSWindow!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        TomatoTimer.shared().mainWindow = mainWindow
    }

}
