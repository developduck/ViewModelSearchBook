//
//  LibraryExtensions.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/25.
//  Copyright © 2020 example. All rights reserved.
//

import Alamofire
import DIKit
import Combine

extension URLRequestConvertible {
    func baseUrl() -> String {
        return (resolve(tag: Common.config) as Config).baseUrl ?? ""
    }
}

extension Alamofire.Session {
    func request<T: Decodable>(type: T.Type = T.self, convertible: URLRequestConvertible) -> AnyPublisher<T, Error> {
        return self.request(convertible)
            .validate(statusCode: 200..<201)
            .publishDecodable(type: type, decoder: JSONDecoder())
            .tryMap {
                if let res = $0.response, let req = $0.request {
                    if res.statusCode == 200 {
                        if let value = $0.value { return value }
                    }
                    var result: ResErrorResult?
                    if let resultData = $0.data {
                        result = try? JSONDecoder().decode(ResErrorResult.self, from: resultData)
                    }
                    throw HttpError.response(code: res.statusCode, data: [
                        "url": req.url?.absoluteString ?? "",
                        "msg_key": result?.msg_key ?? ""
                    ])
                } else {
                    throw HttpError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
