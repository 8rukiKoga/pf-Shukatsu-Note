//
//  ColorExtension.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/06.
//

import Foundation
import SwiftUI

class CustomColor: ObservableObject {
    @AppStorage("theme_color") var themeColor = "ThemeColor"
    static let customBrown = "CustomBrown"
}
