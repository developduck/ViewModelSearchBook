//
//  BookListView.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/19.
//  Copyright © 2020 example. All rights reserved.
//

import SwiftUI
import DIKit

struct BookListView: View {
    @InjectObservedObject var book: BookViewModel

    var body: some View {
        return NavigationView {
            
            VStack {
                EditTextSearchView(text: $book.searchText, hint: "book_list_edt_search_hint")
                Button.init("FatalError") {
                    fatalError()
                }
                List(book.items) { item in
                    BookListItemView(data: item)
                }
            }
            .navigationBarTitle(Text(LocalizedStringKey("book_list_txt_title")))
            .makeToast(isShowing: $book.showToast, key: LocalizedStringKey(book.messageKey))
        }
    }
}

#if DEBUG
struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
#endif
