//
//  CompanyModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import Foundation

struct CompanyModel: Identifiable, Codable, Hashable, Equatable {
    // idで同一か判断するようにする
    static func == (lhs: CompanyModel, rhs: CompanyModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    
    var image: Data?
    var name: String = "未設定"
    var stars: Int = 0
    var category: String = "未設定"
    var location: String = "未設定"
    var url: String = ""
    var memo: String = ""
    var notes = [NoteModel]()
}
