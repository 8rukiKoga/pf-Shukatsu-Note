//
//  CompanyModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import Foundation

struct CompanyModel: Identifiable {
    var id = UUID()
    
    var name: String
    var stars: Int?
    var location: String?
    var url: URL?
    var memo: String?
    var notes: [NoteModel]?
}
