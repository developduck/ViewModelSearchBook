//
//  HttpError.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/21.
//  Copyright © 2020 example. All rights reserved.
//

enum HttpError: Error {
    case response(code: Int?, data: [String:String])
    case cannotParse
    case unknown
}
