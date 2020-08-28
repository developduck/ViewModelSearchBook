//
//  AFBookRouter.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/21.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation
import Alamofire
import DIKit

enum AFBookRouter: URLRequestConvertible {
    case getBookList(text: String)
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl().asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getBookList:
            return .get
        }
    }
    private var path: String {
        switch self {
        case .getBookList:
            return "books/v1/volumes"
        }
    }
    private var parameters: Parameters? {
        switch self {
        case .getBookList(let text):
            return ["q": text]
        }
    }
}
