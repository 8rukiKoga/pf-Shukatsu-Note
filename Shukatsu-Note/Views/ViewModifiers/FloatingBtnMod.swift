//
//  FloatingBttunMod.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/16.
//

import SwiftUI

struct FloatingBtnMod: ViewModifier {
    @EnvironmentObject var customColor: CustomColor
    
    var size: CGFloat = 55
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size / 2.2))
            .foregroundColor(.white)
            .frame(width: size, height: size)
        // うしろの丸の設定
            .background(Color(customColor.themeColor))
            .cornerRadius(size / 2)
            .shadow(color: .gray, radius: 3, x: 1, y: 1)
        // Buttonの端からの距離
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 20))
    }
}
