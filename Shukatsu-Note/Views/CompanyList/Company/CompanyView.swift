//
//  CompanyView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct CompanyView: View {
    
    var company: CompanyModel
    @ObservedObject var companyVm: CompanyViewModel
    @State var memoText: String = "すぐに見たい情報をここに記載します。\n選考フローやマイページのID・パスワードなど"
    @FocusState private var inputFocus: Bool
    
    var body: some View {
        
        List {
            Section {
                VStack(alignment: .leading) {
                    // ＊ 後々アイコンまたは画像を適用・変更できるようにする。
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(width: 120, height: 120)
                            Image(systemName: "chevron.left.forwardslash.chevron.right")
                                .foregroundColor(Color(.systemBackground))
                                .font(.system(size: 60))
                        }
                        Spacer()
                    }
                    // ＊ もっとコードを綺麗にできそう(?)
                    HStack {
                        Text("志望度 : ")
                            .font(.system(size: 15))
                        Spacer()
                        Text("★★★★☆")
                            .foregroundColor(Color(.systemYellow))
                            .fontWeight(.bold)
                    }
                    .padding(.top, 10)
                    .padding(1)
                    HStack {
                        Text("業界・業種 : ")
                            .font(.system(size: 15))
                        Spacer()
                        Text("エンジニア")
                            .font(.system(size: 15))
                    }
                    .padding(1)
                    HStack {
                        Text("所在地 : ")
                            .font(.system(size: 15))
                        Spacer()
                        Text("東京都港区")
                            .font(.system(size: 15))
                    }
                    .padding(1)
                    HStack {
                        Text("URL : ")
                            .font(.system(size: 15))
                        Spacer()
                        Text("https://apps.apple.com/us/app/%E3%81%95%E3%81%B6%E3%81%99%E3%81%8F%E7%AE%A1%E7%90%86/id1617774926?itsct=apps_box_link&itscg=30200")
                            .font(.system(size: 6))
                    }
                    .padding(1)
                    // 簡易メモ
                    TextEditor(text: $memoText)
                        .padding(.horizontal, 2)
                        .frame(height: 100)
                        .background(Color(.systemGray5))
                        .cornerRadius(3)
                        .focused($inputFocus)
                        .padding(.top, 10)
                        .font(.caption)
                }
                .padding()
            } header: {
                HStack {
                    Text("企業情報")
                    Spacer()
                    Button {
                        // 編集画面を開く
                        print("編集")
                    } label: {
                        Text("編集")
                            .font(.system(size: 12))
                    }
                    
                }
            }
            .textCase(nil)
            
            // インデックス特定
            if let index = companyVm.companyList.firstIndex(of: company) {
                Section {
                    ForEach(companyVm.companyList[index].notes) { note in
                        NavigationLink(destination: NoteView(note: NoteModel(text: "New Memo"))) {
                            NoteRowView(note: note)
                        }
                    }
                    
                } header: {
                    HStack {
                        Text("Memo")
                        Spacer()
                        // 新規メモボタン
                        Button {
                            print("new memo")
                            companyVm.companyList[index].notes.append(NoteModel(text: "New Memo"))
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 15))
                        }
                    }
                }
                .textCase(nil)
            }
            
        }
        .listStyle(InsetGroupedListStyle())
        .gesture(
            DragGesture().onChanged({ value in
                if value.translation.height > 0 {
                    inputFocus = false
                }
            })
        )
        
        .navigationTitle(company.name)
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        
        let testCompany = CompanyViewModel()
        testCompany.companyList = sampleCompanies
        
        return Group {
            NavigationView {
                CompanyView(company: .init(name: "A社"), companyVm: testCompany)
            }
            NavigationView {
                CompanyView(company: .init(name: "A社"), companyVm: testCompany)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
