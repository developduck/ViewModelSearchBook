//
//  RepositoryModule.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import DIKit

let repository = module {
    single(tag: Repository.auth) { AuthRepository() as AuthDataSource }
    single(tag: Repository.book) { BookRepository() as BookDataSource }
    factory(tag: Repository.bookLocal) { BookLocalDataSource() as BookDataSource }
    factory(tag: Repository.bookRemote) { BookRemoteDataSource() as BookDataSource }
}
