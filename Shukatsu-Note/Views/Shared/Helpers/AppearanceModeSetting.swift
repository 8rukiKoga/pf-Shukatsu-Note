//
//  AppearanceModeSetting.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/11/20.
//

import SwiftUI

enum AppearanceMode: Int {
    case followSystem = 0
    case darkMode = 1
    case lightMode = 2
}

extension View {
    @ViewBuilder
    func applyAppearenceSetting(_ setting: AppearanceMode) -> some View {
        switch setting {
        case .followSystem:
            self
                .preferredColorScheme(.none)
        case .darkMode:
            self
                .preferredColorScheme(.dark)
        case .lightMode:
            self
                .preferredColorScheme(.light)
        }
    }
}
