//
//  UrlOpener.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/11/18.
//

import SwiftUI

protocol UrlOpener {
    func openUrl(url: String)
}

extension UrlOpener {
    func openUrl(url: String){
        let productURL:URL = URL(string: url)!
        UIApplication.shared.open(productURL)
    }
}
