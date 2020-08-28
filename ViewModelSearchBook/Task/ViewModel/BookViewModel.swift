//
//  BookListViewModel.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/19.
//  Copyright © 2020 example. All rights reserved.
//

import Foundation
import Combine
import DIKit

final class BookViewModel: DefaultViewModel {
    @Published var searchText = ""
    @Published private (set) var items = [Book]() {
        willSet {
            objectWillChange.send()
        }
    }
    @Inject(tag: Repository.book) var repository: BookDataSource
    
    override init () {
        super.init()
        $searchText
            .setFailureType(to: Error.self)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty && $0.first != " " }
            .flatMap { text -> AnyPublisher<[Book], Error> in
                print("text:\(text)")
                return self.repository.getBookList(text: text)
                    .resultError { (result: ErrorResult, error: Error) -> Result<[Book], Error>.Publisher in
                        if let key = result.key {
                            self.messageKey = key
                            self.showToast = true
                        }
                        return Just([]).setFailureType(to: Error.self)
                    }
            }
            .map {
                print("items:\($0)")
                return $0
            }
            .catch { (error) -> Just<[Book]> in
                print("BookViewModel:init:catch")
                return Just([])
            }
            .assign(to: \.items, on: self)
            .store(in: &cancellables)
    }
}
