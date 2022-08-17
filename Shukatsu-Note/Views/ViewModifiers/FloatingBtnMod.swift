//
//  FloatingBttunMod.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/16.
//

import SwiftUI

struct FloatingBtnMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24))
            .foregroundColor(.white)
            .frame(width: 55, height: 55)
        // うしろの青丸の設定
            .background(Color(.systemBrown))
            .cornerRadius(30.0)
            .shadow(color: .gray, radius: 3, x: 1, y: 1)
        // Buttonの端からの距離
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 60, trailing: 25))
    }
}
