//
//  ToastView.swift
//  SingleViewApp
//
//  Created by HwangUiTaek on 2020/08/27.
//  Copyright © 2020 example. All rights reserved.
//

import SwiftUI

struct ToastView<P>: View where P: View {
    @Binding var isShowing: Bool
    let presenting: () -> P
    var text: Text

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.presenting()
                    .blur(radius: self.isShowing ? 1 : 0)
                VStack {
                    self.text
                        .padding(20)
                }
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .transition(.slide)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}
