//
//  ListHeader.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/14.
//

import SwiftUI

struct ListHeader: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @Binding var showingSomething: Bool
    
    var listType: ListType
    var companyId: String?
    
    var body: some View {
        
        switch listType {
        case .note:
            HStack {
                Text("Note")
                
                Spacer()
                // 新規ノート作成ボタン
                Button {
                    Note.create(in: context, companyId: nil)
                    // 新規ノートに遷移する
                    showingSomething.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 15))
                }
                .padding(.trailing, 5)
            }
            
        case .company:
            HStack {
                Text("Company")
                
                Spacer()
                // 新規ノート作成ボタン
                Button {
                    // ポップアップ表示
                    withAnimation {
                        showingSomething = true
                    }
                } label: {
                    Image(systemName: "folder.badge.plus")
                        .font(.system(size: 15))
                }
                .padding(.trailing, 5)
            }
            
        case .companyNote:
            HStack {
                Text("Note")
                
                Spacer()
                // 新規メモボタン
                Button {
                    Note.create(in: context, companyId: companyId)
                    showingSomething.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 15))
                }
            }
            
        case .task:
            Text("Hello, world.")
        }
        
    }
}

struct ListHeader_Previews: PreviewProvider {
    static var previews: some View {
        ListHeader(showingSomething: .constant(false), listType: .note)
    }
}
