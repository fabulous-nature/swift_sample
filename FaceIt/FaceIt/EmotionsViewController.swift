//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by wanghuamin on 2019/6/29.
//  Copyright © 2019 wanghuamin. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        var destinationViewController = segue.destination
        if let navigationController = destinationViewController as? UINavigationController{
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        if let faceViewController = destinationViewController as? FaceViewController,
            let identifier = segue.identifier,let expression = emotionanlFaces[identifier] {
                    faceViewController.expression = expression
                    faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
        }
    }
    
    private let emotionanlFaces: Dictionary<String,FacialExpression> = [
        "sad":FacialExpression(eyes:.closed,mouth: .frown),
        "happy":FacialExpression(eyes: .open, mouth: .smile),
        "worried":FacialExpression(eyes: .open, mouth: .smirk)
    ]

}
