//
//  NoteRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/08.
//

import SwiftUI

struct NoteRowView: View {
    
    @AppStorage(wrappedValue: "ThemeColor1", "theme_color") var themeColor
    
    var text: String
    
    var body: some View {
        
        HStack {
            Image(systemName: "note.text")
                .foregroundColor(Color(themeColor))
                .font(.system(size: 15))
            
            Text(text)
                .font(.system(size: 11))
            
            Spacer()
        }
        .padding(6)
        
    }
}
