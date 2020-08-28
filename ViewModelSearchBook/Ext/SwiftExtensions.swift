//
//  SwiftExtensions.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/21.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation
import Combine
import FirebaseCrashlytics
import DIKit
import SwiftUI

extension View {
    func makeToast(isShowing: Binding<Bool>, key: LocalizedStringKey) -> some View {
        ToastView(isShowing: isShowing, presenting: { self }, text: Text(key))
    }
}

extension String {
    func fromJson<T: Codable>() throws -> T {
        guard let data = self.data(using: .utf8) else { throw HttpError.cannotParse }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension Publisher {
    func resultError<P>(_ handler: @escaping (ErrorResult, Self.Failure) -> P) -> AnyPublisher<Self.Output, P.Failure> where P : Publisher, Self.Output == P.Output {
        return self.catch { (error) -> P in
            let crashlytics = resolve() as Crashlytics
            var result: ErrorResult?
            
            if let http = error as? HttpError {
                switch http {
                case HttpError.response(let code, let data):
                    switch code {
                    case 500:
                        crashlytics.record(error: NSError.init(
                            domain: "HttpError",
                            code: code!,
                            userInfo: data))
                         
                        NSLog("code:%@", String(code ?? -1))
                        data.forEach { (key: String, value: Any) in
                            NSLog("%@:%@", key, String(describing: value))
                        }
                        result = ErrorResult.init(res: data)
                    default:
                        NSLog("code:%@", String(code ?? -1))
                        NSLog("error:%@", String(describing: data))
                    }
                    break
                case .cannotParse:
                    NSLog("cannotParse")
                case .unknown:
                    NSLog("unknown")
                }
            }
            return handler(result ?? ErrorResult.init(), error)
        }
        .eraseToAnyPublisher()
    }
}
