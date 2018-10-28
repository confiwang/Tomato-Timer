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
    fileprivate var statusProgressLayer: CYStatusBarProgressShapeLayer!
    fileprivate var playTimer: Timer!
    fileprivate var currentTime: Int = 0
    fileprivate var tomatoWorkTime: Int = DefaultWorkTime
    fileprivate var finishAngle: CGFloat = 0
    
    //显示程序在系统状态栏
    fileprivate let statusItem =  NSStatusBar.system.statusItem(withLength: StatusMenuProgressRadius*2)
    
    override func awakeFromNib() {
        
        //action时间与下拉菜单不能共存m，下拉菜单优先
        //        statusItem.button?.target = self
        //        statusItem.button?.action = #selector(StatusMenuController.showTimerManagerr)
        
        statusItem.button?.title = ""
        statusItem.menu = statusMenu
        finishAngle = CGFloat(ProgressBeginAngle)
        
        statusProgressLayer = CYStatusBarProgressShapeLayer()
        statusProgressLayer.frame = (statusItem.button?.bounds)!
        statusProgressLayer.finishAngle = 0
        statusProgressLayer.contentsScale = (NSScreen.main?.backingScaleFactor)!
        statusItem.button?.wantsLayer = true
        statusItem.button?.layer?.addSublayer(statusProgressLayer)
        statusProgressLayer.display()
        
        let currentTimeItem = statusMenu.item(at: 0)
        currentTimeItem?.isHidden = true
        
        let startItem = statusMenu.item(at: 1)
        startItem?.title = "Start"
        
        TomatoTimer.shared().statusMenuController = self
    }
    
    @IBAction func quitTimer(_ sender: NSMenuItem) {
        NSLog("Quit Timer")
        NSApplication.shared.terminate(self)
    }
    
    @IBAction func restartTimer(_ sender: NSMenuItem) {
        startTomatoTimmer()
        TomatoTimer.shared().mainViewController.startTimmer(self)
        
        let currentTimeItem = statusMenu.item(at: 0)
        currentTimeItem?.isHidden = false
        
        let startItem = statusMenu.item(at: 1)
        startItem?.title = "Restart"
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
        
        playTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1/TomatoTimerSpeedup), target: self, selector: #selector(startTomatoTimerWork), userInfo: nil, repeats: true)
        currentTime = Int(tomatoWorkTime)
        playTimer.fire()
    }
    
    func stopTomatoTimmer() {
        
        if playTimer != nil{
            playTimer.invalidate()
            playTimer = nil
        }
        let currentTimeItem = statusMenu.item(at: 0)
        currentTimeItem?.isHidden = true
        
        let startItem = statusMenu.item(at: 1)
        startItem?.title = "Start"
    }
    
    @objc func startTomatoTimerWork() {
    
        currentTime = currentTime-1
        statusProgressLayer.finishAngle = 360.0*(CGFloat(tomatoWorkTime-currentTime)/CGFloat(tomatoWorkTime))
        //调用drawrect绘制
        statusProgressLayer.setNeedsDisplay()
        
        let currentTimeItem = statusMenu.item(at: 0)
        currentTimeItem?.title = String(format: "%02d:%02d", currentTime/60, currentTime%60)
    }
    
}
