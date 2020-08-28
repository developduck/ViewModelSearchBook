//
//  SearchBookBar.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/20.
//  Copyright © 2020 example. All rights reserved.
//

import SwiftUI

struct SearchEditTextView : View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
            Color.gray
            HStack {
                TextField("type a book name...", text: $text)
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
