//
//  BookServiceImpl.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import Combine
import DIKit

class URLSessionBookServiceImpl: BookService {
    @Inject(tag: Common.config) var config: Config
    
    func getBookList(text: String) -> AnyPublisher<[Book], Error> {
        var request = URLRequest(url: (URL(string: (config.baseUrl ?? "") + "/books/v1/volumes?q=" + text))!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.send(request: request)
            .decode(type: BookItem.self, decoder: JSONDecoder())
            .tryMap {
                guard let books = $0.items else { throw HttpError.cannotParse }
                return books
            }
            .eraseToAnyPublisher()
    }
}

extension URLSession {
    func send(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                let response = response as? HTTPURLResponse
                if let res = response, 200..<300 ~= res.statusCode {
                    return data
                } else if let res = response {
                    throw HttpError.response(code: res.statusCode, data: [
                        "domain": res.description,
                        "code": String(res.statusCode),
                        "userInfo": String(describing: res.allHeaderFields)
                    ])
                } else {
                    throw HttpError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
    func syncDataTask(with url: URLRequest) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        let semaphore = DispatchSemaphore(value: 0)
        let dataTask = self.dataTask(with: url) {
            data = $0
            response = $1
            error = $2

            semaphore.signal()
        }
        dataTask.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        return (data, response, error)
    }
}
