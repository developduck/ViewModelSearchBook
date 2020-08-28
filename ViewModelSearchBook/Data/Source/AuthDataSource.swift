//
//  AuthDataSource.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/24.
//  Copyright © 2020 example. All rights reserved.
//

protocol AuthDataSource {
    func getSession() -> Session
    func putSession(session: Session)
}
