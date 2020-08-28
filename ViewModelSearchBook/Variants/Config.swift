//
//  Config.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation

struct Config {
    var variant: String?
    var baseUrl: String?
    
    init() {
        if let dictionary = Bundle.main.infoDictionary,
            let configuration = dictionary["BuildVariant"] as? String {
            let path = Bundle.main.path(forResource: "BuildVariants", ofType:"plist")
            let config = NSDictionary(contentsOfFile: path!)
            for (key, value) in config! {
                if let key = key as? String,
                    let value = value as? [String:String] {
                    if key == configuration {
                        variant = configuration
                        baseUrl = value["baseUrl"]
                    }
                }
            }
        }
    }
}
