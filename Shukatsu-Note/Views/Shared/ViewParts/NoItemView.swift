//
//  NoItemView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/13.
//

import SwiftUI

struct NoItemView: View {
    
    var listType: ListType
    
    var body: some View {
        
        HStack {
            Spacer()
            
            Text("\(listType.rawValue)がありません✖︎\n\(listType == .task ? "下" : "右上")のボタンから\(listType.rawValue)を追加できます。")
                .font(.footnote)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .opacity(0.6)
        .padding(.vertical, 30)
        
    }
}
