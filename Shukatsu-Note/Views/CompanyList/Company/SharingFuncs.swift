//
//  SharingFuncs.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/12.
//

import SwiftUI

func ConvertIntToStars(count: Int) -> String {
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
    
    return "未設定"
}
