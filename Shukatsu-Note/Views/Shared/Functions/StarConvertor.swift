//
//  SharingFuncs.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/12.
//

import Foundation

protocol StarConvertor {
    func convertIntToStars(count: Int) -> String
}

extension StarConvertor {
    func convertIntToStars(count: Int) -> String {
        if count == 1 {
            return "★☆☆☆☆"
        }
        
        if count == 2 {
            return "★★☆☆☆"
        }
        
        if count == 3 {
            return "★★★☆☆"
        }
        
        if count == 4 {
            return "★★★★☆"
        }
        
        if count == 5 {
            return "★★★★★"
        }
        
        return NSLocalizedString("未設定", comment: "")
    }
}
