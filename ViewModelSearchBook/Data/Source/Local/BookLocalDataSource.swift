//
//  BookLocalDataSource.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import Combine

class BookLocalDataSource: BookDataSource {
    func getBookList(text: String) -> AnyPublisher<[Book], Error> {
        return AnyPublisher<[Book], Error>.init(Result.Publisher.init(Result.failure(TypedError.notImplemented)))
    }
}
