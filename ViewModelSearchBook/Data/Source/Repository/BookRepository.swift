//
//  BookRepository.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import Combine
import DIKit

class BookRepository: BookDataSource {
    @Inject(tag: Repository.bookLocal) var local: BookDataSource
    @Inject(tag: Repository.bookRemote) var remote: BookDataSource
    
    func getBookList(text: String) -> AnyPublisher<[Book], Error> {
        return remote.getBookList(text: text)
    }
}
