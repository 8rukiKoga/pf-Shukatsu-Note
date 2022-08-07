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
