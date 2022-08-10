//
//  NoteModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/07.
//

import Foundation

struct NoteModel: Identifiable, Codable, Equatable {
    // idで同一か判断するようにする
    static func == (lhs: NoteModel, rhs: NoteModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    
    var text: String = ""
}
