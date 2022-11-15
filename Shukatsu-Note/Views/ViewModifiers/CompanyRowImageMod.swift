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
            .frame(width: 60, height: 60)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding(3)
    }
}

