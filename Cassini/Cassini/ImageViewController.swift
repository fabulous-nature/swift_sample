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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private func fetchImage(){
        if let url = imageURL{
            //this next line of code can throw an error
            //and it also will block the UI entirely while access the network
            //we really should be doing it in a separate thread
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {[weak self] in
                let urlContents = try? Data(contentsOf: url)
                if let imageData = urlContents,url == self?.imageURL{
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(imageView)
        //imageURL = DemoURL.stanford
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
            //careful here because scrollview might be nil
            //(for example, if we're setting our image as part of a prepare)
            //so use optional chaining to do nothing
            //if out scrollview outlet has not yet been set
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
}

extension ImageViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
