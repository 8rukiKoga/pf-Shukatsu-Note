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
            
            Text(String(format: NSLocalizedString("%@がありません✖︎\n%@のボタンから%@を追加できます。", comment: ""), listType.rawValue, listType == .task ? NSLocalizedString("下", comment: "") : NSLocalizedString("右上", comment: ""), listType.rawValue))
                    .font(.footnote)
                    .foregroundColor(.gray)
            
            Spacer()
        }
        .opacity(0.6)
        .padding(.vertical, 30)
        
    }
}
