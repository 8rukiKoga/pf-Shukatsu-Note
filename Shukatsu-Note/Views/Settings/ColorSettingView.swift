//
//  ColorSettingView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/14.
//

import SwiftUI

struct ColorSettingView: View {
    @EnvironmentObject var customColor: CustomColor
    var colorSet: [String] = [
        "ThemeColor1", "ThemeColor2", "ThemeColor3", "ThemeColor4", "ThemeColor5", "ThemeColor6"
    ]
    
    var body: some View {
        VStack  {
            VStack(spacing: 100) {
                
                Color(customColor.themeColor)
                    .frame(width: 230, height: 80)
                    .cornerRadius(13)
                
                VStack {
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 0), count: 3), spacing: 0, content: {
                        ForEach(0..<colorSet.count) { item in
                            Button {
                                customColor.themeColor = colorSet[item]
                            } label: {
                                Color(colorSet[item])
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

struct ColorSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSettingView()
    }
}
