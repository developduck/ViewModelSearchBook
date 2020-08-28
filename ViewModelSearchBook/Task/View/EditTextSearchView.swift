//
//  SearchBookBar.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import SwiftUI

struct EditTextSearchView : View {
    @Binding var text: String
    var hint: LocalizedStringKey
    
    var body: some View {
        ZStack {
            Color.gray
            HStack {
                TextField(hint, text: $text)
                    .padding([.leading, .trailing], 8)
                    .frame(height: 32)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(8)
            }
            .padding([.leading, .trailing], 16)
        }
        .frame(height: 64)
    }
}

#if DEBUG
struct EditTextSearchView_Previews: PreviewProvider {
    static var previews: some View {
        let text = Binding<String>.constant("")
        return EditTextSearchView(text: text, hint: "book_list_edt_search_hint")
    }
}
#endif
