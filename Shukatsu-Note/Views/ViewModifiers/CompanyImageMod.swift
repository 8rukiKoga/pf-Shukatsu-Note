//
//  CompanyImageMod.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/22.
//

import SwiftUI

struct CompanyImageMod: ViewModifier {
    
    var size: CGFloat = 60
    
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: size, height: size)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.lightGray), lineWidth: 1)
            )
    }
}
