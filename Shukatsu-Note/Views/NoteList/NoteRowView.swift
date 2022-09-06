//
//  NoteRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/08.
//

import SwiftUI

struct NoteRowView: View {
    
    @ObservedObject var companyVm: CompanyViewModel
    @ObservedObject var noteVm: NoteViewModel
    var isInFolder: Bool
    var companyIndex: Int?
    
    var note: NoteModel
    
    var body: some View {
        if let noteIndex = noteVm.noteList.firstIndex(of: note) {
            HStack {
                Image(systemName: "note.text")
                    .foregroundColor(Color("ThemeColor"))
                    .font(.system(size: 15))
                Text(noteVm.noteList[noteIndex].text)
                    .font(.system(size: 15))
                Spacer()
            }
            .frame(height: 25)
        }
    }
}

struct NoteRowView_Previews: PreviewProvider {
    static var previews: some View {
        NoteRowView(companyVm: CompanyViewModel(), noteVm: NoteViewModel(), isInFolder: true, note: .init(text: "メモメモ"))
            .previewLayout(.sizeThatFits)
    }
}
