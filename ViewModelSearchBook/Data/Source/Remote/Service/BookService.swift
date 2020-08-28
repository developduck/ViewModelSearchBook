//
//  BookService.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import Combine

protocol BookService {
    func getBookList(text: String) -> AnyPublisher<[Book], Error>
}
