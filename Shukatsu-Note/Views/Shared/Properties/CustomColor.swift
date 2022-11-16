//
//  ColorExtension.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/06.
//

import Foundation
import SwiftUI

class CustomColor: ObservableObject {
    @AppStorage("theme_color") var themeColor = "ThemeColor1"
    
    static let themeColor1 = "ThemeColor1"
    static let themeColor2 = "ThemeColor2"
    static let themeColor3 = "ThemeColor3"
    static let themeColor4 = "ThemeColor4"
    static let themeColor5 = "ThemeColor5"
    static let themeColor6 = "ThemeColor6"
}
