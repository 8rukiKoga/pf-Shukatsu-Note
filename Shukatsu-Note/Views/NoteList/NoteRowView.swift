//
//  NoteRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/08.
//

import SwiftUI

struct NoteRowView: View {
    @EnvironmentObject var customColor: CustomColor
    
    var text: String
    
    var body: some View {
        
            HStack {
                Image(systemName: "note.text")
                    .foregroundColor(Color(customColor.themeColor))
                    .font(.system(size: 15))
                Text(text)
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
