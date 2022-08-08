//
//  NoteEditView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct NoteView: View {
    var note: NoteModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: .init(title: "就活ガムバル", text: "メモメモ"))
    }
}
