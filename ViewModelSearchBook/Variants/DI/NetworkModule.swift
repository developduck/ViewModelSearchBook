//
//  NetworkModule.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/21.
//  Copyright © 2020 example. All rights reserved.

import DIKit

var network = { () -> DependencyContainer in
    if let variant = (Bundle.main.infoDictionary?["BuildVariant"] as? String) {
        if (!variant.isEmpty) {
            return networkImpl
        }
    }
    return module {
        factory { DummyBookServiceImpl() as BookService }
    }
}()
