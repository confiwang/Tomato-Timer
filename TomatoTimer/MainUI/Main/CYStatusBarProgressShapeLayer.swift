//
//  CYStatusBarProgressShapeLayer.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/10/27.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Cocoa

class CYStatusBarProgressShapeLayer: CAShapeLayer {

    var finishAngle: CGFloat = 0.0
    
    override func draw(in ctx: CGContext) {
        super .draw(in: ctx)

        ctx.translateBy(x: frame.width/2, y: frame.height/2)
        
        let ciclePath = NSBezierPath()
        ciclePath.appendArc(withCenter: NSZeroPoint, radius: StatusMenuProgressRadius-StatusMenuProgressLineWidth, startAngle: 0, endAngle: 360)
        ctx.setLineWidth(1)
        NSColor.black.setStroke()
        ctx.saveGState()
        ctx.addPath(ciclePath.quartzPath())
        ctx.move(to: NSZeroPoint)
        ctx.addLine(to: NSMakePoint(0, -StatusMenuProgressRadius+StatusMenuProgressLineWidth))
        ctx.drawPath(using: CGPathDrawingMode.stroke)
        ctx.setStrokeColor(CGColor.black)
        ctx.restoreGState()
        ctx.saveGState()
        
        ctx.rotate(by: StatusMenuProgressRotateDegrees)
        let fanPath = NSBezierPath()
        fanPath.appendArc(withCenter: NSZeroPoint, radius: StatusMenuProgressRadius-StatusMenuProgressLineWidth, startAngle: 0, endAngle: CGFloat(finishAngle))
        fanPath.line(to: NSZeroPoint)
        ctx.addPath(fanPath.quartzPath())
        ctx.setFillColor(CGColor.black)
        ctx.drawPath(using: CGPathDrawingMode.fill)
        ctx.restoreGState()
    }
}
