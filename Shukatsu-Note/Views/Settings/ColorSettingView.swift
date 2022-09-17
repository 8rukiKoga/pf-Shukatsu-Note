//
//  ColorSettingView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/14.
//

import SwiftUI

struct ColorSettingView: View {
    
    @EnvironmentObject private var customColor: CustomColor
    
    private let colorSet: [String] = [
        CustomColor.themeColor1, CustomColor.themeColor2, CustomColor.themeColor3, CustomColor.themeColor4, CustomColor.themeColor5, CustomColor.themeColor6
    ]
    
    var body: some View {
        
        VStack  {
            VStack(spacing: 100) {
                
                Color(customColor.themeColor)
                    .frame(width: 230, height: 80)
                    .cornerRadius(13)
                
                VStack {
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 0), count: 3), spacing: 0, content: {
                        ForEach(colorSet, id: \.self) { color in
                            Button {
                                customColor.themeColor = color
                            } label: {
                                Color(color)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .padding()
                            }
                        }
                    })
                }
                .padding(.horizontal, 30)
                .navigationTitle("Color Setting")
            }
        }
        
    }
}
