//
//  NetworkImplModule.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import DIKit
import Alamofire

let networkImpl = module {
    // Service
    factory { AFBookServiceImpl() as BookService }
    
    // Module
    single { Alamofire.Session.init(interceptor: resolve() as RequestInterceptor) }
    factory { AFRequestInterceptor() as RequestInterceptor }

}
