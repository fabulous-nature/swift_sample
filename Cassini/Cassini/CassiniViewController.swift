//
//  CassiniViewController.swift
//  Cassini
//
//  Created by wanghuamin on 2019/7/13.
//  Copyright © 2019 wanghuamin. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let url = DemoURL.NASA[segue.identifier ?? ""]{
            if let imageVC = (segue.destination as? ImageViewController){
                imageVC.imageURL = url
                imageVC.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
    
}

extension UIViewController{
    var Contents: UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController ?? self
        }else {
            return self
        }
    }
}
