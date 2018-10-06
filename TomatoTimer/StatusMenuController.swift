//
//  StatusMenuController.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/10/6.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    
    //显示程序在系统状态栏
    let statusItem =  NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    override func awakeFromNib() {
        statusItem.button?.title = "Tomato Timer"
        statusItem.menu = statusMenu
    }
    
    @IBAction func quitTimer(_ sender: NSMenuItem) {
        NSLog("Quit Timer")
        NSApplication.shared.terminate(self)
    }
    
    @IBAction func restartTimer(_ sender: NSMenuItem) {
        
    }
    
    @IBAction func stopTimer(_ sender: NSMenuItem) {
        
    }
    
    @IBAction func showTimerManager(_ sender: NSMenuItem) {
        TomatoTimer.shared().mainWindow .makeKeyAndOrderFront(self)
    }
}
