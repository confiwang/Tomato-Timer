//
//  TomatoTimer.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/10/6.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Cocoa

class TomatoTimer: NSObject {
    
    var mainWindow: NSWindow!
    var statusMenuController: StatusMenuController!
    var mainViewController: MainViewController!
    
    private static let sharedManager: TomatoTimer = {
        let shared = TomatoTimer()
        
        return shared
    }()
    
    class func shared() -> TomatoTimer {
        return sharedManager
    }
}
