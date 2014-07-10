//
//  PlayPauseIconView.swift
//  SwiftForm
//
//  Created by Jordan Rose on 7/9/14.
//  Copyright (c) 2014 Jordan Rose. All rights reserved.
//

import UIKit

class PlayPauseIconView: UIView {
    var isPlaying = false
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        if isPlaying {
            // already playing, so draw a pause icon
            drawPausePathTo(context, boundedBy: rect)
        } else {
            // not playing, draw a play icon
            drawPlayPathTo(context, boundedBy: rect)
        }
    }
    func drawPlayPathTo(context: CGContextRef, boundedBy rect: CGRect) {
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextMoveToPoint(context, rect.width / 4, rect.height / 4)
        CGContextAddLineToPoint(context, rect.width * 3 / 4, rect.height / 2)
        CGContextAddLineToPoint(context, rect.width / 4, rect.height * 3 / 4)
        CGContextAddLineToPoint(context, rect.width / 4, rect.height / 4)
        CGContextFillPath(context)
    }
    func drawPausePathTo(context: CGContextRef, boundedBy rect: CGRect) {
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextMoveToPoint(context, rect.width / 4, rect.height / 4)
        CGContextAddLineToPoint(context, rect.width / 4, rect.height * 3 / 4)
        CGContextAddLineToPoint(context, rect.width * 2 / 5, rect.height * 3 / 4)
        CGContextAddLineToPoint(context, rect.width * 2 / 5, rect.height / 4)
        CGContextAddLineToPoint(context, rect.width / 4, rect.height / 4)
        CGContextFillPath(context)
        CGContextMoveToPoint(context, rect.width * 3 / 4, rect.height / 4)
        CGContextAddLineToPoint(context, rect.width * 3 / 4, rect.height * 3 / 4)
        CGContextAddLineToPoint(context, rect.width * 3 / 5, rect.height * 3 / 4)
        CGContextAddLineToPoint(context, rect.width * 3 / 5, rect.height / 4)
        CGContextAddLineToPoint(context, rect.width * 3 / 4, rect.height / 4)
        CGContextFillPath(context)
    }
}
