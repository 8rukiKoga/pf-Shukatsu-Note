//
//  CompanyRowImageMod.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/10/10.
//

import SwiftUI

struct CompanyRowImageMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: 36, height: 36)
            .clipShape(Circle())
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

