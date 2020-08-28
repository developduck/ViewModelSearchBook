//
//  BookServiceImpl.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation
import Combine
import DIKit
import Alamofire

class URLSessionBookServiceImpl: BookService {
    @Inject(tag: Common.config) var config: Config
    
    func getBookList(param: String) -> AnyPublisher<[Book], Error> {
        var request = URLRequest(url: (URL(string: (config.baseUrl ?? "") + "books/v1/volumes?q=" + param))!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.send(request: request)
            .decode(type: BookItem.self, decoder: JSONDecoder())
            .tryMap {
                guard let books = $0.items else { throw RequestError.cannotParse }
                return books
            }
            .eraseToAnyPublisher()
    }
}

enum RequestError: Error {
    case request(code: Int, error: Error?)
    case cannotParse
    case unknown
}

extension URLSession {
    func send(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                let httpResponse = response as? HTTPURLResponse
                if let httpResponse = httpResponse, 200..<300 ~= httpResponse.statusCode {
                    return data
                }
                else if let httpResponse = httpResponse {
                    throw RequestError.request(code: httpResponse.statusCode, error: NSError(domain: httpResponse.description, code: httpResponse.statusCode, userInfo: httpResponse.allHeaderFields as? [String : Any]))
                }     else {
                    throw RequestError.unknown
                }
           
            }
            .eraseToAnyPublisher()
    }
}
