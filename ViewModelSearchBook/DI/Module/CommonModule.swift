//
//  CommonImplModule.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import FirebaseCrashlytics
import DIKit

let common = module {
    factory { Crashlytics.crashlytics() }
    
    single(tag: Common.config) { Config() }
}
