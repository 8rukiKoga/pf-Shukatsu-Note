//
//  VerifyUrl.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/11.
//

import Foundation
import SwiftUI

final class VerifyUrl {
    
    static let shared = VerifyUrl()
    
    private init() {}
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
}


