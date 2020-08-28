//
//  ViewModelModule.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import DIKit
import SwiftUI

let viewModel = module {
    factory { BookViewModel() }
}
