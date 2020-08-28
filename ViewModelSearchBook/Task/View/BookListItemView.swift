//
//  BookListRow.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import SwiftUI

struct BookListItemView: View {
    private let data: Book
    
    init(data: Book) {
        self.data = data
    }
    var body: some View {
        HStack {
            Text(data.volumeInfo?.title ?? "")
        }
    }
}
