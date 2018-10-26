//
//  CFTextField.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/10/24.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Cocoa

typealias funcBlock = ()->()

class CFTextField: NSTextField {

    var textDidChangeBlock:funcBlock? = nil

    
    override func textDidChange(_ notification: Notification) {
        if ((textDidChangeBlock) != nil) {
            textDidChangeBlock!()
        }
    }
}
