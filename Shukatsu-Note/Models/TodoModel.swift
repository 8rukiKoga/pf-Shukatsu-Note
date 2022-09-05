//
//  TodoModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/14.
//

import Foundation

struct TodoModel: Identifiable, Codable, Hashable, Equatable {
    // idで同一か判断するようにする
    static func == (lhs: TodoModel, rhs: TodoModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    // 企業と紐づく場合は、その企業のuuidを持っておく
    var companyID: UUID?
    var companyName: String?
    
    var name: String = ""
    var date: Date?
    var dateIsSet: Bool = true
    var done: Bool = false
}
