//
//  CompanyModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import Foundation

struct CompanyModel: Identifiable, Equatable {
    // 企業名で同一か判断するようにする(＊ 後々同じ企業名は入力できないように制御する)
    static func == (lhs: CompanyModel, rhs: CompanyModel) -> Bool {
        return lhs.name == rhs.name
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
