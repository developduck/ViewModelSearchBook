//
//  AFRequestInterceptor.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/24.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation
import Alamofire
import DIKit

class AFRequestInterceptor: Alamofire.RequestInterceptor {
    @Inject(tag: Repository.auth) var respository: AuthDataSource

    func adapt(_ urlRequest: URLRequest, for session: Alamofire.Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let session = respository.getSession()
        var request = urlRequest
        print("token:\(session.token)")
        request.addValue(session.token, forHTTPHeaderField: "x-access-token")
        completion(.success(request))
    }
    func retry(_ request: Request, for session: Alamofire.Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let statusCode = request.response?.statusCode {
            switch statusCode {
            case 401:
                let session = respository.getSession()
                AF.request(AFAuthRouter.updToken(refreshToken: session.refreshToken), interceptor: self)
                    .responseDecodable(of: Session.self, decoder: JSONDecoder(), completionHandler: {
                        if $0.response?.statusCode == 200 && $0.value != nil {
                            self.respository.putSession(session: $0.value!)
                            completion(.retry)
                        } else {
                            completion(.doNotRetryWithError(TypedError.expiredSession))
                        }
                    })
            default:
                completion(.doNotRetry)
            }
        } else {
            completion(.doNotRetry)
        }
    }
}
