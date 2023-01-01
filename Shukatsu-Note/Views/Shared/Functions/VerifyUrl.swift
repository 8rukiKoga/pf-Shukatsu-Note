//
//  VerifyUrl.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/11.
//

import SwiftUI

protocol UrlVerification {
    func verifyUrl(urlString: String?) -> Bool
}

extension UrlVerification {
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}
