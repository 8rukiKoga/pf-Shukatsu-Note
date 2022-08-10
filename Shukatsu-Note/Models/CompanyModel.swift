//
//  CompanyModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import Foundation

struct CompanyModel: Identifiable, Codable, Equatable {
    // idで同一か判断するようにする
    static func == (lhs: CompanyModel, rhs: CompanyModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    
    var name: String
    var stars: Int?
    var category: String?
    var location: String?
    var url: String?
    var memo: String?
    var notes = [NoteModel]()
}
