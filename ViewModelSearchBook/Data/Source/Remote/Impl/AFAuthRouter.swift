//
//  AFAuthRouter.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/24.
//  Copyright © 2020 example. All rights reserved.
//

import Alamofire
import DIKit

enum AFAuthRouter: URLRequestConvertible {
    case updToken(refreshToken: String)
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl().asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        headers?.forEach { (key: String, value: String) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: nil)
    }
    
    private var method: HTTPMethod {
        switch self {
        case .updToken:
            return .put
        }
    }
    private var path: String {
        switch self {
        case .updToken:
            return "auth/token"
        }
    }
    private var headers: [String:String]? {
        switch self {
        case .updToken(let refreshToken):
            return ["x-refresh-token": refreshToken]
        }
    }
}
