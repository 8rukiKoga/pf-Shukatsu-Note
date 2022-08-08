//
//  NoteViewModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/07.
//

import Foundation

class NoteViewModel: ObservableObject {
    @Published var noteList = [NoteModel]()
}

var sampleNotes = [
    NoteModel(text: "自己分析結果"),
    NoteModel(text: "自己PR"),
    NoteModel(text: "志望動機の書き方")
]
