//
//  FaceView.swift
//  Happiness
//
//  Created by Xiangli Jin on 16/1/25.
//  Copyright © 2016年 Xiangli Jin. All rights reserved.
//

import UIKit


protocol FaceViewDataSource: class {
    func smilinessForFaceView(sender: FaceView)-> Double?
}

@IBDesignable
class FaceView: UIView {

    
    var lineWidth:CGFloat = 3{ didSet{ setNeedsDisplay()}}
    var color:UIColor = UIColor.blueColor(){ didSet{setNeedsDisplay()}}
    var scale:CGFloat = 0.90 { didSet{setNeedsDisplay()}}
    
    var faceCenter: CGPoint{
        return  convertPoint(center, fromView:  superview)
    }

    var faceRadius:CGFloat{
        return min(bounds.size.width,bounds.size.height) / 2 * scale
    }
    
    
    var faceEndAngle: CGFloat{
        return CGFloat(2*M_PI)
    }

    weak var faceViewDataSource: FaceViewDataSource?
    
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 5
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRadio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    
    
    private enum Eye {case Left, Right}
    
    private func bezierPathForEye(whichEye : Eye) -> UIBezierPath
    {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontaSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        switch whichEye{
            case .Left: eyeCenter.x -= eyeHorizontaSeparation / 2
            case .Right:eyeCenter.x += eyeHorizontaSeparation / 2
        }
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: faceEndAngle, clockwise: true)
        path.lineWidth = lineWidth
        return path
    }
    
    private func bezierForSmile(fractionOfMaxSmile: Double) ->UIBezierPath
    {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRadio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileHegiht = CGFloat(max(min(fractionOfMaxSmile, 1),-1)) * mouthHeight
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y )
        let cp1 = CGPoint(x: start.x + mouthWidth / 3 , y: start.y + smileHegiht)
        let cp2 = CGPoint(x: end.x - mouthWidth/3, y: cp1.y)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
        
        
    }
    
    

    override func drawRect(rect: CGRect) {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: faceEndAngle, clockwise: true);
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()
        let smiliness = faceViewDataSource?.smilinessForFaceView(self) ?? 0.0
        let smilpath = bezierForSmile(smiliness)
        smilpath.stroke()
    }


}
