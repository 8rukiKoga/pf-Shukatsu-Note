//
//  NoteModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/07.
//

import Foundation

struct NoteModel: Identifiable {
    var id = UUID()
    
    var text: String = ""
}
