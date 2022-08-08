//
//  NoteRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/08.
//

import SwiftUI

struct NoteRowView: View {
    var note: NoteModel
    
    var body: some View {
        HStack {
            Image(systemName: "note.text")
                .foregroundColor(Color(.systemBrown))
                .font(.system(size: 20))
            Text(note.title)
                .font(.system(size: 15))
            Spacer()
        }
    }
}

struct NoteRowView_Previews: PreviewProvider {
    static var previews: some View {
        NoteRowView(note: .init(title: "就活ガムバル", text: "メモメモ"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
