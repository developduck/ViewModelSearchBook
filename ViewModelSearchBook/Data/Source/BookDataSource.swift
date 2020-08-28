//
//  MovieDataSource.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/19.
//  Copyright © 2020 example. All rights reserved.
//

import Combine

protocol BookDataSource {
    func getBookList(text: String) -> AnyPublisher<[Book], Error>
}
