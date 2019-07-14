//
//  CassiniViewController.swift
//  Cassini
//
//  Created by wanghuamin on 2019/7/13.
//  Copyright © 2019 wanghuamin. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController,UISplitViewControllerDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let url = DemoURL.NASA[segue.identifier ?? ""]{
            var destinationViewController = segue.destination
            if let navigationController = destinationViewController as? UINavigationController{
                destinationViewController = navigationController.visibleViewController ?? destinationViewController
            }
            if let imageVC = (destinationViewController as? ImageViewController){
                imageVC.imageURL = url
                imageVC.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
    
    
    //显示主屏幕
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.Contents == self{
            if let ivc = secondaryViewController.Contents as? ImageViewController, ivc.imageURL == nil{
                return true
            }
        }
        return false
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
