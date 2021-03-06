//
//  UIDefine.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/10/20.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Foundation

enum TomatoTimerStatus {
    case TomatoTimerOrigin
    case TomatoTimerStop
    case TomatoTimerOriginRunning
}

//Main
let DefaultWorkTime: Int = 1500
//StatusMenu
let StatusMenuProgressLineWidth: CGFloat = 1
let StatusMenuProgressRadius: CGFloat = 10
let StatusMenuProgressRotateDegrees: CGFloat = CGFloat(Double.pi/2*3)


//MainViewController
let MainViewControllerProgressLineWidth: CGFloat = 3
let MainViewControllerProgressRotateDegrees: CGFloat = 90

let ProgressBeginAngle = 0.0 // 起点
let ProgressFinishAngle = 360.0 // 终点

let TomatoTimerSpeedup = 1 //加速时间流转

let CFFtomatoManagerWindowDidResize = Notification.Name("tomatoManagerWindowDidResize")
