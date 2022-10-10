//
//  TextCountValidation.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/14.
//

import Foundation

final class TextCountValidation {
    static let shared = TextCountValidation()
    init() { }
    
    func isTextCountValid(text: String, max: Int) -> Bool {
        if text.count <= max {
            return true
        }
        return false
    }
}
