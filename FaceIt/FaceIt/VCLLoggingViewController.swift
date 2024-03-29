//
//  VCLLoggingViewController.swift
//  FaceIt
//
//  Created by wanghuamin on 2019/7/6.
//  Copyright © 2019 wanghuamin. All rights reserved.
//

import UIKit

class VCLLoggingViewController: UIViewController {
    
    private struct LogGlobals{
        var prefix = ""
        var instanceCounts = [String:Int]()
        var lastLogTime = Date()
        var indentationInterval: TimeInterval = 1
        var indentationString = "__"
    }
    
    private static var logGlobals = LogGlobals()
    
    private static func logPrefix(for className: String)->String{
        if logGlobals.lastLogTime.timeIntervalSinceNow < -logGlobals.indentationInterval{
            logGlobals.prefix += logGlobals.indentationString
            print("")
        }
        logGlobals.lastLogTime = Date()
        return logGlobals.prefix + className
    }
    
    private static func bumpInstanceCount(for className: String)->Int{
        logGlobals.instanceCounts[className] = (logGlobals.instanceCounts[className] ?? 0)+1
        return logGlobals.instanceCounts[className]!
    }
    
    private var instanceCount: Int!
    
    private func logVCL(_ msg: String){
        let className = String(describing: type(of: self))
        if instanceCount == nil{
            instanceCount = VCLLoggingViewController.bumpInstanceCount(for: className)
        }
        print("\(VCLLoggingViewController.logPrefix(for: className))(\(instanceCount!)) \(msg)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        logVCL("init(coder:) - created via InterfaceBuilder")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        logVCL("init(nibName:bundle:) - create in code")
    }
    
    deinit {
        logVCL("left the heap")
    }

    override func awakeFromNib() {
        logVCL("awakeFromNib()")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logVCL("viewDidLoad()")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logVCL("viewWillAppear(animated = \(animated))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logVCL("viewDidAppear(animated = \(animated))")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logVCL("viewWillDisappear(animated = \(animated))")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logVCL("viewDidDisappear(animated = \(animated))")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        logVCL("didReceiveMemoryWarning()")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logVCL("viewDidLayoutSubviews()")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logVCL("viewWillLayoutSubviews()")
    }
    
    override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        logVCL("viewLayoutMarginsDidChange()")
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        logVCL("viewSafeAreaInsetsDidChange()")
    }
}
