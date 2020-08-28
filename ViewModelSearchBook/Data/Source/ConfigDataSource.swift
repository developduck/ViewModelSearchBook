//
//  RemoteConfig.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/27.
//  Copyright © 2020 example. All rights reserved.
//

import Combine

protocol ConfigDataSource {
    func getRequiredVersion() -> AnyPublisher<String, Error>
    func getOptionalVersion() -> AnyPublisher<String, Error>
}
