//
//  AFBookServiceImpl.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/21.
//  Copyright © 2020 example. All rights reserved.
//

import Combine
import Alamofire
import DIKit

class AFBookServiceImpl: BookService {
    @Inject var manager: Alamofire.Session
    
    func getBookList(text: String) -> AnyPublisher<[Book], Error> {
        return manager.request(type: BookItem.self, convertible: AFBookRouter.getBookList(text: text))
            .map { $0.items ?? [] }
            .eraseToAnyPublisher()
    }
}
