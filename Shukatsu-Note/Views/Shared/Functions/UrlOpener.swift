//
//  UrlOpener.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/11/18.
//

import SwiftUI

final class UrlOpener {
    static let shared = UrlOpener()
    private init() {}
    
    // urlを開く
    func openUrl(url: String){
        let productURL:URL = URL(string: url)!
        UIApplication.shared.open(productURL)
    }
}
