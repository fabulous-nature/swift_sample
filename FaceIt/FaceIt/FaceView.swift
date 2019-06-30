//
//  FaceView.swift
//  FaceIt
//
//  Created by wanghuamin on 2019/6/25.
//  Copyright © 2019 wanghuamin. All rights reserved.
//

import UIKit
@IBDesignable //可以使属性在开发界面设置
class FaceView: UIView {

    @IBInspectable
    var scale: CGFloat = 0.9 {
        didSet{
            setNeedsDisplay() //重画
        }}
    
    @IBInspectable
    var eyesOpen: Bool = true {
        didSet{
            setNeedsDisplay()
        }}
    
    @IBInspectable
    var lineWidth: CGFloat = 5.0{
        didSet{
            setNeedsDisplay()
        }}
    
    @IBInspectable
    var color: UIColor = UIColor.blue
    
   @objc func changeScale(byReactingTo pinchRecognizer: UIPinchGestureRecognizer){
        switch  pinchRecognizer.state {
        case .changed, .ended:
            scale *= pinchRecognizer.scale
            pinchRecognizer.scale = 1
        default:
            break
        }
    
    }
    
    @IBInspectable
    var mouthCurvature: Double = 1.0 //1.0 is full smile and -1.0 is full frown
    
    private var skullRadius: CGFloat{
        return min(bounds.size.width,bounds.size.height) / 2 * scale
    }
    
    private var skullCenter: CGPoint{
            return CGPoint(x: bounds.midX, y: bounds.midY)
    
    }
    
    private enum Eye{
        case left
        case right
    }
    
    
    private func pathForMouth() ->UIBezierPath{
        let mouthWith = skullRadius / Ratios.skullRadiusToMouthWidth
        let moutHeight = skullRadius / Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadiudToMouthOffset
        
        let mouthRect = CGRect(
            x: skullCenter.x - mouthWith/2,
            y: skullCenter.y+mouthOffset,
            width: mouthWith,
            height: moutHeight
        )
        let smileOffset = CGFloat(max(-1,min(mouthCurvature, 1))) * mouthRect.height
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3 ,y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3, y: start.y + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
         path.lineWidth = lineWidth
        return path
    }
    
    private func pathForEye(_ eye: Eye)->UIBezierPath{
        func centerOfEye(_ eye: Eye) ->CGPoint{
            let eyeOffset = skullRadius / Ratios.skullRadiudToMouthOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1)*eyeOffset
            return eyeCenter
        }
        
        let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        let path: UIBezierPath
        if eyesOpen {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        }else{
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
        }
        
        path.lineWidth = lineWidth
        return path
        
    }
    
    private func pathForSkull() -> UIBezierPath{
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = lineWidth
        return path
    }
    
    override func draw(_ rect: CGRect) {
        color.set()
        pathForSkull().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
    }
    
    private struct Ratios{
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiudToMouthOffset: CGFloat = 3
    }


}
