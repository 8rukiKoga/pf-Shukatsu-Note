//
//  ListHeader.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/14.
//

import SwiftUI

struct ListHeader: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @State private var showingAlert: Bool = false
    
    @Binding var showingSomething: Bool
    
    var listType: ListType
    
    var companyId: String?
    
    var companyCount: Int = 0
    
    var noteCount: Int = 0
    
    var taskCount: Int = 0
    
    var body: some View {
        
        switch listType {
        case .note:
            HStack {
                Text("Note")
                
                if noteCount > 70 {
                    Text("\(noteCount) / 100")
                        .font(.system(size: 8))
                        .padding(.leading, 1)
                }
                
                Spacer()
                // 新規ノート作成ボタン
                Button {
                    if noteCount < 100 {
                        Note.create(in: context, companyId: nil)
                        // 新規ノートに遷移する
                        showingSomething.toggle()
                    } else {
                        showingAlert = true
                    }
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 15))
                }
                .padding(.trailing, 5)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("登録可能ノート数の上限(150)に達しています。"))
                }
            }
            
        case .company:
            HStack {
                Text("Company")
                
                Text("\(companyCount) / 30")
                    .font(.system(size: 8))
                    .padding(.leading, 1)
                
                Spacer()
                // 新規ノート作成ボタン
                Button {
                    if companyCount < 30 {
                        // ポップアップ表示
                        withAnimation {
                            showingSomething = true
                        }
                    } else {
                        showingAlert = true
                    }
                } label: {
                    Image(systemName: "folder.badge.plus")
                        .font(.system(size: 15))
                }
                .padding(.trailing, 5)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("登録可能企業数の上限(20)に達しています。"))
                }
            }
            
        case .companyNote:
            HStack {
                Text("Note")
                
                if noteCount > 70 {
                    Text("\(noteCount) / 100")
                        .font(.system(size: 8))
                        .padding(.leading, 1)
                }
                
                Spacer()
                // 新規メモボタン
                Button {
                    if noteCount < 100 {
                        Note.create(in: context, companyId: companyId)
                        showingSomething.toggle()
                    } else {
                        showingAlert = true
                    }
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 15))
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("登録可能ノート数の上限(150)に達しています。"))
                }
            }
            
        case .task:
            HStack {
                Spacer()
                if taskCount > 2 {
                    Text("\(taskCount) / 200")
                        .font(.system(size: 8))
                        .padding(.leading, 1)
                }
            }
        }
        
    }
}

struct ListHeader_Previews: PreviewProvider {
    static var previews: some View {
        ListHeader(showingSomething: .constant(false), listType: .company)
    }
}
