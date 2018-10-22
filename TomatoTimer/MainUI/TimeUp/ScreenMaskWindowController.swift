//
//  ScreenMaskWindowController.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/10/21.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Cocoa

class ScreenMaskWindowController: NSWindowController {

    @IBOutlet weak var screenMaskWindow: NSWindow!
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            self.keyDown(with: $0)
            return $0
        }
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    override func keyDown(with event: NSEvent) {
        
        if (event.keyCode == 53) {
            self.window?.close()
        }
    }
}
