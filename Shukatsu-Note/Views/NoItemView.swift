//
//  NoItemView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/13.
//

import SwiftUI

enum ListType: String {
    case note = "ノート"
    case company = "企業"
    case todo = "タスク"
}

struct NoItemView: View {
    var listType: ListType
    
    var body: some View {
        
        HStack {
            Spacer()
            Text("\(listType.rawValue)がありません😢\n\(listType == .todo ? "下" : "右上")のボタンから\(listType.rawValue)を追加できます。")
                .font(.footnote)
                .foregroundColor(.gray)
            Spacer()
        }
        .opacity(0.6)
        .padding(.vertical, 30)
        
    }
}

struct NoItemView_Previews: PreviewProvider {
    static var previews: some View {
        NoItemView(listType: .todo)
    }
}
