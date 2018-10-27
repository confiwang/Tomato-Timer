//
//  StatusMenuController.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/10/6.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Cocoa



class StatusMenuController: NSObject {
    
    @IBOutlet weak var statusMenu: NSMenu!
    fileprivate var statusProgressLayer: CAShapeLayer!
    fileprivate var playTimer: Timer!
    fileprivate var currentTime: Int = 0
    fileprivate var tomatoWorkTime: CGFloat = DefaultWorkTime
    
    //显示程序在系统状态栏
    fileprivate let statusItem =  NSStatusBar.system.statusItem(withLength: StatusMenuProgressRadius*2)
    
    override func awakeFromNib() {
        
        //action时间与下拉菜单不能共存m，下拉菜单优先
        //        statusItem.button?.target = self
        //        statusItem.button?.action = #selector(StatusMenuController.showTimerManagerr)
        
        statusItem.button?.title = ""
        statusItem.menu = statusMenu
        progressAnimate()
        
        TomatoTimer.shared().statusMenuController = self
    }
    
    @IBAction func quitTimer(_ sender: NSMenuItem) {
        NSLog("Quit Timer")
        NSApplication.shared.terminate(self)
    }
    
    @IBAction func restartTimer(_ sender: NSMenuItem) {
        startTomatoTimmer()
        TomatoTimer.shared().mainViewController.startTimmer(self)
    }
    
    @IBAction func stopTimer(_ sender: NSMenuItem) {
        stopTomatoTimmer()
        TomatoTimer.shared().mainViewController.stopTimmer(self)
    }
    
    @IBAction func showTimerManager(_ sender: NSMenuItem) {
        TomatoTimer.shared().mainWindow.makeKeyAndOrderFront(self)
    }
    
    func startTomatoTimmer() {
        stopTomatoTimmer()
        
        playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTomatoTimerWork), userInfo: nil, repeats: true)
        currentTime = Int(tomatoWorkTime)
        playTimer.fire()
    }
    
    func stopTomatoTimmer() {
        
        if playTimer != nil{
            playTimer.invalidate()
            playTimer = nil
        }
    }
    
    @objc func startTomatoTimerWork() -> Void {
        
        currentTime = currentTime-1
        statusProgressLayer.strokeEnd = CGFloat(currentTime)/tomatoWorkTime
        if (statusProgressLayer.strokeEnd < 0) {
            statusProgressLayer.strokeEnd = 1
        }
    }
    
    func progressAnimate() {
        
        statusProgressLayer = CAShapeLayer()
        statusProgressLayer.frame = (statusItem.button?.bounds)!
        statusItem.button?.wantsLayer = true
        statusItem.button?.layer?.addSublayer(statusProgressLayer)
        let onePath = NSBezierPath()
        
        onePath.appendArc(withCenter: NSZeroPoint, radius: StatusMenuProgressRadius-StatusMenuProgressLineWidth, startAngle: 0, endAngle: 360)
        onePath.transform(using: AffineTransform (rotationByDegrees: StatusMenuProgressRotateDegrees))
        onePath.transform(using: AffineTransform (translationByX: statusProgressLayer.frame.width/2, byY: statusProgressLayer.frame.height/2))
        
        statusProgressLayer.path = onePath.quartzPath()
        statusProgressLayer.lineWidth = StatusMenuProgressLineWidth
        statusProgressLayer.strokeStart = 0
        statusProgressLayer.strokeEnd = 1
        statusProgressLayer.strokeColor = NSColor.red.cgColor
        statusProgressLayer.fillColor = NSColor.clear.cgColor
    }
}
