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
    
    var note: Note
    
    var body: some View {
        
            HStack {
                Image(systemName: "note.text")
                    .foregroundColor(Color("ThemeColor"))
                    .font(.system(size: 15))
                Text("note text")
                    .font(.system(size: 15))
                Spacer()
            }
            .frame(height: 25)
        
    }
}

//struct NoteRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteRowView(companyVm: CompanyViewModel(), noteVm: NoteViewModel(), isInFolder: true, note: .init(text: "メモメモ"))
//            .previewLayout(.sizeThatFits)
//    }
//}
