//
//  NoItemView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/13.
//

import SwiftUI

struct NoItemView: View {
    
    var listType: ListType
    
    let prefLang = Locale.preferredLanguages.first
    
    var body: some View {
        
        HStack {
            Spacer()
            
            if ((prefLang?.hasPrefix("en")) != nil){
               //英語の時の処理
            } else if ((prefLang?.hasPrefix("ja")) != nil){
               //日本語の時の処理
                Text("\(listType.rawValue)がありません✖︎\n\(listType == .task ? "下" : "右上")のボタンから\(listType.rawValue)を追加できます。")
                    .font(.footnote)
                    .foregroundColor(.gray)
            } else{
               //その他言語の時の処理
            }
            
            Spacer()
        }
        .opacity(0.6)
        .padding(.vertical, 30)
        
    }
}
