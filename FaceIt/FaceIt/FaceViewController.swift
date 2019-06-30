//
//  ViewController.swift
//  FaceIt
//
//  Created by wanghuamin on 2019/6/25.
//  Copyright © 2019 wanghuamin. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView!{
        didSet{
            //手势通过 view 改变图形。图形和model 数据不一致
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            
            //手势通过 model 改变图形  那么这是通过 controler 控制
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byRectingTo:)))
            tapRecognizer.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecognizer)
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(inscreaseHappiness))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            updateUI()
        }
    }
    
   @objc func toggleEyes(byRectingTo tapRecognizer: UITapGestureRecognizer){
        if tapRecognizer.state == .ended{
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    @objc func inscreaseHappiness(){
        expression = expression.happier
    }
    
    @objc func decreaseHappiness(){
        expression = expression.sadder
    }
    
    var expression = FacialExpression(eyes:.open, mouth: .grin){
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    
    private let mouthCurvatures = [FacialExpression.Mouth.grin:0.5,.frown:-1.0,.smile:1.0,.neutral:0.0,.smirk:-0.5]
    
}

