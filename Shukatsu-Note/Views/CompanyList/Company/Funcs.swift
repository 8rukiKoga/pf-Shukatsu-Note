//
//  Funcs.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/11.
//

import Foundation

// Rowのテキストの長さを調整する関数
func stripString(text: String) -> String {
    if text.count > 20 {
        let rowText = String(text.prefix(20) + "...")
        return rowText
    }
    return text
}
