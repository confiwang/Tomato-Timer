//
//  ScreenMaskViewController.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/10/24.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Cocoa

class ScreenMaskViewController: NSViewController {

    @IBOutlet weak var backgroundImageView: NSImageView!
    
    @IBOutlet weak var userGreetingInputTextField: CFTextField!
    @IBOutlet weak var greetingsTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        greetingsTextField.stringValue = "休息一下"
        userGreetingInputTextField.textDidChangeBlock = {
            if (self.greetingsTextField.stringValue == self.userGreetingInputTextField.stringValue) {
                self.view.window?.close()
            }
        }
    }
}
