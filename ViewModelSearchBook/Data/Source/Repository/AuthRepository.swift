//
//  AuthRepository.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/24.
//  Copyright © 2020 example. All rights reserved.
//

import Combine
import DIKit

class AuthRepository: AuthDataSource {
    private var session: Session?
    
    func getSession() -> Session {
        return session ?? Session(token: "expired_access_token", refreshToken: "prev_not_expired_refresh_token")
    }
    func putSession(session: Session) {
        self.session = session
    }
}
