//
//  DemoURL.swift
//  Cassini
//
//  Created by wanghuamin on 2019/7/7.
//  Copyright © 2019 wanghuamin. All rights reserved.
//

import Foundation

struct DemoURL{
    static let stanford = URL(string: "http://pic31.nipic.com/20130729/8952533_173610669000_2.jpg")
    
    static var NASA: Dictionary<String,URL> = {
        let NASARLString = [
            "Cassini" : "http://pic36.nipic.com/20131126/8821914_071759099000_2.jpg",
            "Earth" : "http://pic38.nipic.com/20140301/6608733_073013180000_2.jpg",
            "Saturn" : "http://pic.58pic.com/58pic/15/02/65/67d58PICkMZ_1024.jpg"
        ]
        var urls = Dictionary<String,URL>()
        for(key,value) in NASARLString{
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
