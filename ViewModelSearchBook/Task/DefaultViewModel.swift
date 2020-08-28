//
//  DefaultViewModel.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/27.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation
import Combine

open class DefaultViewModel: ObservableObject {
    @Published var showToast: Bool = false
    var messageKey: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        $showToast.filter { $0 }
            .delay(for: 2, scheduler: DispatchQueue.main)
            .map {
                print(!$0)
                return !$0
            }
            .assign(to: \.showToast, on: self)
            .store(in: &cancellables)
    }
}
