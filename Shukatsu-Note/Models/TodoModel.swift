//
//  TodoModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/14.
//

import Foundation

struct TodoModel: Identifiable, Codable, Equatable {
    // idで同一か判断するようにする
    static func == (lhs: TodoModel, rhs: TodoModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    
    var name: String = ""
    
    var company: CompanyModel?
    // var memo: String = ""
    var done: Bool = false
}
