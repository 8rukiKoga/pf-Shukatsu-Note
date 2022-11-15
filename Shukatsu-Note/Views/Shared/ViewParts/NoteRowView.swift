//
//  NoteRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/08.
//

import SwiftUI

struct NoteRowView: View {
    
    @EnvironmentObject private var customColor: CustomColor
    
    var text: String
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            HStack {
                Image(systemName: "note.text")
                    .foregroundColor(Color(customColor.themeColor))
                    .font(.system(size: 15))
                
                Text(text)
                    .font(.system(size: 11))
                
                Spacer()
            }
            .frame(height: 25)
            .padding()
        }
        .cornerRadius(10)
        .padding(.vertical, 1)
    }
}
