//
//  MainViewController.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/9/29.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    @IBOutlet weak var lastTimeTextField: NSTextField!
    @IBOutlet weak var progressView: NSView!
    @IBOutlet weak var startTimerButton: NSButton!
    
    fileprivate var playTimer: Timer!
    fileprivate var currentTime: Int = 0
    fileprivate var progressLayer: CAShapeLayer!
    fileprivate var tomatoWorkTime: Int = DefaultWorkTime
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressAnimate()
        TomatoTimer.shared().mainViewController = self
        self.view.wantsLayer = true
        self.view.layer?.contentsGravity = kCAGravityResizeAspect
        self.view.layer?.contents = NSImage(named: NSImage.Name(rawValue: "background_chicken"))
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.tomatoWindowDidResize(notification:)), name: CFFtomatoManagerWindowDidResize, object: nil)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func startTimer(_ sender: Any) {
        
        if ((playTimer) != nil) {
            playTimer.invalidate()
            playTimer = nil
        }
        playTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1/TomatoTimerSpeedup), target: self, selector: #selector(startTomatoTimerWork), userInfo: nil, repeats: true)
        currentTime = Int(tomatoWorkTime)
        playTimer.fire()
        TomatoTimer.shared().statusMenuController.startTomatoTimer()
        TomatoTimer.shared().tomatoTimerStatus = .TomatoTimerOriginRunning
        startTimerButton.title = "Restart"
        
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        if playTimer != nil{
            playTimer.invalidate()
            playTimer = nil
        }
        TomatoTimer.shared().statusMenuController.stopTomatoTimer()
        TomatoTimer.shared().tomatoTimerStatus = .TomatoTimerStop
        startTimerButton.title = "Start"
    }
    
    @objc func startTomatoTimerWork() -> Void {
        
        if (currentTime == 0) {
            let result = TimeUpManager.shared().estopScreen()
            if (result) {
                
            }
            stopTimer(self);
            return
        }
        
        currentTime = currentTime-1
        progressLayer.strokeEnd = CGFloat(currentTime)/CGFloat(tomatoWorkTime)
        
        if (progressLayer.strokeEnd <= 0) {
            progressLayer.strokeEnd = 1
        }
        lastTimeTextField.stringValue = String(format: "%02d:%02d", currentTime/60, currentTime%60)
        progressLayer.setNeedsDisplay()
    }
    
    func progressAnimate() {
        
        progressLayer = CAShapeLayer()
        progressLayer.frame = progressView.bounds.insetBy(dx: 0, dy: 0)
        progressView.wantsLayer = true
        progressView.layer?.addSublayer(progressLayer)
        
        let onePath = NSBezierPath()
        let radius = progressLayer.frame.width/2-MainViewControllerProgressLineWidth > 0
        ? progressLayer.frame.width/2-MainViewControllerProgressLineWidth:1
        
        onePath.appendArc(withCenter: NSZeroPoint, radius: radius, startAngle: 0, endAngle: 360)
        onePath.transform(using: AffineTransform (rotationByDegrees: MainViewControllerProgressRotateDegrees))
        onePath.transform(using: AffineTransform (translationByX: progressLayer.frame.width/2, byY: progressLayer.frame.height/2))
        
        progressLayer.path = onePath.quartzPath()
        progressLayer.lineWidth = MainViewControllerProgressLineWidth
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 1
        progressLayer.strokeColor = NSColor.red.cgColor
        progressLayer.fillColor = NSColor.clear.cgColor
    }
    
    @objc func tomatoWindowDidResize(notification: NSNotification) {
        progressLayer.frame.size = progressView.frame.size
        
        let onePath = NSBezierPath()
        let radius = min(progressLayer.frame.width, progressLayer.frame.height)/2-MainViewControllerProgressLineWidth*2 > 0
            ? min(progressLayer.frame.width, progressLayer.frame.height)/2-MainViewControllerProgressLineWidth*2:1
        
        onePath.appendArc(withCenter: NSZeroPoint, radius: radius, startAngle: 0, endAngle: 360)
        onePath.transform(using: AffineTransform (rotationByDegrees: MainViewControllerProgressRotateDegrees))
        onePath.transform(using: AffineTransform (translationByX: progressLayer.frame.width/2, byY: progressLayer.frame.height/2))
        
        progressLayer.path = onePath.quartzPath()
        progressLayer.setNeedsDisplay()
        
    }
}

