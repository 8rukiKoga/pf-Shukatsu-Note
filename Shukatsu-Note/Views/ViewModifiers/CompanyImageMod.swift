//
//  CompanyImageMod.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/22.
//

import SwiftUI

struct CompanyImageMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .shadow(color: .gray, radius: 2, x: 0, y: 0)
    }
}
