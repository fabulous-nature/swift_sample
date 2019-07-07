//
//  ImageViewController.swift
//  Cassini
//
//  Created by wanghuamin on 2019/7/7.
//  Copyright © 2019 wanghuamin. All rights reserved.
//

import UIKit

//class ImageViewController: UIViewController, UIScrollViewDelegate {
class ImageViewController: UIViewController {
    var imageURL: URL?{
        didSet{
            image = nil
            if view.window != nil{
                fetchImage()
            }
        }
    }
    
    private func fetchImage(){
        if let url = imageURL{
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents{
                image = UIImage(data: imageData)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(imageView)
        imageURL = DemoURL.stanford
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil{
            fetchImage()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
}

extension ImageViewController : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}