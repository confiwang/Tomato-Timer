//
//  TimeUpManager.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/10/21.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Cocoa

class TimeUpManager: NSObject {
    
    fileprivate var screenMaskWindowController: ScreenMaskWindowController?
    
    private static let sharedManager: TimeUpManager = {
        let shared = TimeUpManager()
        
        return shared
    }()
    
    class func shared() -> TimeUpManager {
        return sharedManager
    }
    
    override init() {
        super.init()
        
        let ScreenMaskStoryBoard = NSStoryboard(name: "Main", bundle: nil)
        screenMaskWindowController = ScreenMaskStoryBoard.instantiateController(withIdentifier: "screenMaskWindow") as? ScreenMaskWindowController
        
        
    }
    
    func estopScreen() -> Bool {
        
        let screenFrame = NSScreen.main?.frame
        let screenCGImage = CGDisplayCreateImage(CGMainDisplayID())
        let screenImage: NSImage = NSImage(cgImage: screenCGImage!, size: (screenFrame?.size)!)
        
        let screenMaskViewController = screenMaskWindowController?.contentViewController as! ScreenMaskViewController
        
        screenMaskViewController.backgroundImageView.image = screenImage
        
        screenMaskWindowController?.window?.setFrame(screenFrame!, display: true)
        screenMaskWindowController?.showWindow(self)
        
        return true
    }
}
