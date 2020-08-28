//
//  ErrorResult.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/27.
//  Copyright © 2020 example. All rights reserved.
//

struct ErrorResult {
    var key: String?
    
    init() {}
    init(res: [String:String]) {
        res.forEach { (key: String, value: String) in
            if key == "msg_key" {
                self.key = value
            }
        }
    }
}
