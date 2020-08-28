//
//  RemoteConfigRepository.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/27.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation
import Combine

class ConfigRpository: ConfigDataSource {
    func getRequiredVersion() -> AnyPublisher<String, Error> {
        return AnyPublisher<String, Error>.init(Result.Publisher.init(Result.success("0.9.0")))
    }
    func getOptionalVersion() -> AnyPublisher<String, Error> {
        return AnyPublisher<String, Error>.init(Result.Publisher.init(Result.success("1.1.0")))
    }
}
