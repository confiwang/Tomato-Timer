//
//  NSBezierPath+ BezierPathQuartzUtilities.swift
//  TomatoTimer
//
//  Created by confiwang on 2018/10/18.
//  Copyright © 2018 confiwang. All rights reserved.
//

import Cocoa

extension NSBezierPath {
    func quartzPath() -> CGPath {
        
        // Need to begin a path here.
        var immutablePath: CGMutablePath = CGMutablePath.init()
        
        // Then draw the path elements.
        let numElements = self.elementCount
        if (numElements > 0)
        {
            let path: CGMutablePath = CGMutablePath()
            let points: NSPointArray = NSPointArray.allocate(capacity: 3)
            var didClosePath: Bool = true
        
            for index in 0..<numElements {
                switch (self.element(at: index, associatedPoints:points)) {
                case NSBezierPath.ElementType.moveToBezierPathElement:
                    path.move(to: points[0])
                    didClosePath = false;
                    break;
                    
                case NSBezierPath.ElementType.lineToBezierPathElement:
                    path.addLine(to: points[0])
                    
                    didClosePath = false;
                    break;
                    
                case NSBezierPath.ElementType.curveToBezierPathElement:
                    path.addCurve(to: points[2], control1: points[0], control2: points[1])
                    
                    didClosePath = false;
                    break;
                    
                case NSBezierPath.ElementType.closePathBezierPathElement:
                    path.closeSubpath();
                    didClosePath = true;
                    break;
                }
            }
            // Be sure the path is closed or Quartz may not do valid hit detection.
            if (!didClosePath) {
                path.closeSubpath();
            }

            immutablePath = path.copy() as! CGMutablePath;
        }
        

        return immutablePath;
    }
    
}
