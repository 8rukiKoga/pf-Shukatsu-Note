//
//  NoteViewModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/07.
//

// MainListViewから直接アクセスできるようにするNoteのViewModel

import Foundation

class NoteViewModel: ObservableObject {
    @Published var noteList: [NoteModel] = [] {
        didSet {
            saveNotes()
        }
    }
    
    init() {
        getNotes()
    }
    
    let noteListKey = "noteListKey"
    
    // データを読み込む
    func getNotes() {
        guard
            let data = UserDefaults.standard.data(forKey: noteListKey),
            let savedNotes = try? JSONDecoder().decode([NoteModel].self, from: data)
        else { return }
        
        noteList = savedNotes
    }
    
    func deleteNote(indexSet: IndexSet) {
        noteList.remove(atOffsets: indexSet)
    }
    
    func moveNote(from: IndexSet, to: Int) {
        noteList.move(fromOffsets: from, toOffset: to)
    }
    
    func addNote(text: String) {
        let newNote = NoteModel(text: text)
        noteList.append(newNote)
    }
    
    func saveNotes() {
        if let encodedData = try? JSONEncoder().encode(noteList) {
            UserDefaults.standard.set(encodedData, forKey: noteListKey)
        }
    }
}

var sampleNotes = [
    NoteModel(text: "自己分析結果"),
    NoteModel(text: "自己PR"),
    NoteModel(text: "志望動機の書き方")
]
