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
        userGreetingInputTextField.placeholderString = "请输入以上文字："
        
        greetingsTextField.mas_remakeConstraints {[unowned self](make:MASConstraintMaker?) in
            make?.center.equalTo()(self.backgroundImageView)
        }
        
        userGreetingInputTextField.mas_remakeConstraints {[unowned self](make:MASConstraintMaker?) in
            make?.height.equalTo()(self.greetingsTextField)?.with()?.offset()(-15)
            make?.width.equalTo()(self.greetingsTextField)?.with()?.offset()(100)
            make?.bottom.equalTo()(self.greetingsTextField)?.offset()(60)
            make?.left.equalTo()(self.greetingsTextField)?.offset()(-50)
        }
        
        userGreetingInputTextField.textDidChangeBlock = {
            if (self.greetingsTextField.stringValue == self.userGreetingInputTextField.stringValue) {
                self.view.window?.close()
            }
        }
    }
}
