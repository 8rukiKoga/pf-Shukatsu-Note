//
//  AppLogoMod.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/22.
//

import SwiftUI

struct AppLogoMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .cornerRadius(12)
            .padding(5)
    }
}
