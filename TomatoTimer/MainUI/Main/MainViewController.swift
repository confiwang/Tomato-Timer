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
    fileprivate var playTimer: Timer!
    fileprivate var currentTime: Int = 0
    fileprivate var progressLayer: CAShapeLayer!
    fileprivate var tomatoWorkTime: CGFloat = DefaultWorkTime
    
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
            playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTomatoTimerWork), userInfo: nil, repeats: true)
            currentTime = Int(tomatoWorkTime)
            playTimer.fire()
            TomatoTimer.shared().statusMenuController.startTomatoTimmer()
        }
    }
    
    @IBAction func stopTimmer(_ sender: Any) {
            
        stopTimmer();
    }
    
    @objc func startTomatoTimerWork() -> Void {
        
        if (currentTime == 0) {
            let result = TimeUpManager.shared().estopScreen()
            if (result) {
                
            }
            stopTimmer();
            return
        }
        
        currentTime = currentTime-1
        progressLayer.strokeEnd = CGFloat(currentTime)/tomatoWorkTime
        if (progressLayer.strokeEnd < 0) {
            progressLayer.strokeEnd = 1
        }
        lastTimeTextField.stringValue = String(format: "%02d:%02d", currentTime/60, currentTime%60)
    }
    
    func progressAnimate() {
        
        progressLayer = CAShapeLayer()
        progressLayer.frame = progressView.bounds.insetBy(dx: 10, dy: 10)
        progressView.wantsLayer = true
        progressView.layer?.addSublayer(progressLayer)

        let onePath = NSBezierPath()

        onePath.appendArc(withCenter: NSZeroPoint, radius: MainViewControllerProgressRadius, startAngle: 0, endAngle: 360)
        onePath.transform(using: AffineTransform (rotationByDegrees: MainViewControllerProgressRotateDegrees))
        onePath.transform(using: AffineTransform (translationByX: progressLayer.frame.width/2, byY: progressLayer.frame.height/2))
        
        progressLayer.path = onePath.quartzPath()
        progressLayer.lineWidth = MainViewControllerProgressLineWidth
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 1
        progressLayer.strokeColor = NSColor.red.cgColor
        progressLayer.fillColor = NSColor.clear.cgColor
    }
    
    func stopTimmer() {
        
        if playTimer != nil{
            playTimer.invalidate()
            playTimer = nil
        }
        TomatoTimer.shared().statusMenuController.stopTomatoTimmer()
    }
    
}

