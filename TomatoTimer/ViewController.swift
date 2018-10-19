//
//  ViewController.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/9/29.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var lastTimeTextField: NSTextField!
    @IBOutlet weak var progressView: NSView!
    fileprivate var playTimer: Timer!
    fileprivate var currentTime: Int = 0
    var progressLayer: CAShapeLayer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressAnimate()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func startTimmer(_ sender: Any) {
        if playTimer == nil {
            playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTomatoTimerWork), userInfo: nil, repeats: true);
            currentTime = 1500;
            playTimer.fire()
            return
        }
        
    }
    
    @IBAction func stopTimmer(_ sender: Any) {
            
        if playTimer != nil{
            playTimer.invalidate()
            playTimer = nil;
        }
    }
    
    @objc func startTomatoTimerWork() -> Void {
        lastTimeTextField.stringValue = String(format: "%02d:%02d", currentTime/60, currentTime%60);
        currentTime = currentTime-1;
        progressLayer.strokeEnd += 0.1;
        if (progressLayer.strokeEnd > 1) {
            progressLayer.strokeEnd = 0;
        }
    }
    
    func progressAnimate() {
        
        progressLayer = CAShapeLayer()
        progressLayer.frame = progressView.bounds.insetBy(dx: 10, dy: 10)
        progressView.wantsLayer = true
        progressView.layer?.addSublayer(progressLayer)
        let onePath = NSBezierPath(ovalIn: progressLayer.bounds)
        progressLayer.path = onePath.quartzPath();
        progressLayer.lineWidth = 3;
        progressLayer.strokeStart = 0;
        progressLayer.strokeEnd = 0;
        progressLayer.strokeColor = NSColor.red.cgColor
        progressLayer.fillColor = NSColor.clear.cgColor
    }
}

