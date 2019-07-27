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
        
        let ScreenMaskStoryBoard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        screenMaskWindowController = ScreenMaskStoryBoard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "screenMaskWindow")) as? ScreenMaskWindowController
        
        
    }
    
    func estopScreen() -> Bool {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            let screenFrame = NSScreen.main?.frame
            let screenCGImage = CGDisplayCreateImage(CGMainDisplayID())
            let screenImage: NSImage = NSImage(cgImage: screenCGImage!, size: (screenFrame?.size)!)
            
            let screenMaskViewController = self.screenMaskWindowController?.contentViewController as! ScreenMaskViewController
            
            screenMaskViewController.backgroundImageView.image = screenImage
            
            self.screenMaskWindowController?.window?.setFrame(screenFrame!, display: true)
            self.screenMaskWindowController?.showWindow(self)
        }
        
        return true
    }
}
