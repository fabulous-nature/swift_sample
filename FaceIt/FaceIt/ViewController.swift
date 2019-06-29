//
//  ViewController.swift
//  FaceIt
//
//  Created by wanghuamin on 2019/6/25.
//  Copyright © 2019 wanghuamin. All rights reserved.
//

import UIKit
@objcMembers
class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView!{
        didSet{
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            updateUI()
        }
    }
    
    var expression = FacialExpression(eyes:.open, mouth: .grin){
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        switch  expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    
    private let mouthCurvatures = [FacialExpression.Mouth.grin:0.5,.frown:-1.0,.smile:1.0,.neutral:0.0,.smirk:-0.5]
    
}

