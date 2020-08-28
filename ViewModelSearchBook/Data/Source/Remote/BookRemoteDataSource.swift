//
//  BookRemoteDataSource.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import Combine
import DIKit

class BookRemoteDataSource: BookDataSource {
    @Inject var service: BookService

    func getBookList(text: String) -> AnyPublisher<[Book], Error> {
        return service.getBookList(text: text)
    }
}
