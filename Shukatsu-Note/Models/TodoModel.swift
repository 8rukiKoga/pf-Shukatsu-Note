//
//  TodoModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/14.
//

import Foundation

struct TodoModel: Identifiable, Codable {
    var id = UUID()
    
    var name: String = ""
    // var memo: String = ""
    var done: Bool = false
}
