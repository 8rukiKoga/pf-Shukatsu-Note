//
//  JsonManager.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/11.
//

// https://app.quicktype.io/ にて生成

import Foundation

struct WelcomeElement: Codable {
    let code: Int
    let name, en: String
    
    static let allPrefectures: [WelcomeElement] = Bundle.main.decode(file: "prefectures.json")
}

typealias Welcome = [WelcomeElement]

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        print(data)
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
}
