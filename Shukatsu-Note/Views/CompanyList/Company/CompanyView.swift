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
    
    @State private var showingSheet: Bool = false
    
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
                        Text("\(company.stars)")
                            .foregroundColor(Color(.systemYellow))
                            .fontWeight(.bold)
                    }
                    .padding(.top, 10)
                    .padding(1)
                    HStack {
                        Text("業界・業種 : ")
                            .font(.system(size: 15))
                        Spacer()
                        Text(company.category)
                            .font(.system(size: 15))
                    }
                    .padding(1)
                    HStack {
                        Text("所在地 : ")
                            .font(.system(size: 15))
                        Spacer()
                        Text(company.location)
                            .font(.system(size: 15))
                    }
                    .padding(1)
                    HStack {
                        Text("URL : ")
                            .font(.system(size: 15))
                        Spacer()
                        Text(company.url)
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
                        showingSheet = true
                    } label: {
                        Text("編集")
                            .font(.system(size: 12))
                    }
                    .fullScreenCover(isPresented: $showingSheet, content: {
                        EditCompanyView(showingSheet: $showingSheet, companyVm: companyVm, company: company, name: company.name, stars: company.stars, category: company.category, location: company.location, url: company.url)
                    })
                }
            }
            .textCase(nil)
            
            // 企業インデックス特定
            if let companyIndex = companyVm.companyList.firstIndex(of: company) {
                Section {
                    ForEach(companyVm.companyList[companyIndex].notes) { note in
                        NavigationLink(destination: NoteView(isInFolder: true, note: note, companyIndex: companyIndex, companyVm: companyVm, noteVm: NoteViewModel())) {
                            NoteRowView(companyVm: companyVm, noteVm: NoteViewModel(), isInFolder: true, companyIndex: companyIndex, note: note)
                        }
                    }
                    
                } header: {
                    HStack {
                        Text("Note")
                        Spacer()
                        // 新規メモボタン
                        Button {
                            companyVm.companyList[companyIndex].notes.append(NoteModel(text: "New Memo"))
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
        
        let testNote = NoteViewModel()
        testNote.noteList = sampleNotes
        
        return Group {
            NavigationView {
                CompanyView(company: CompanyModel(name: "name", stars: 1, category: "cat", location: "loc", url: "url", memo: "memo", notes: []), companyVm: testCompany)
            }
            NavigationView {
                CompanyView(company: CompanyModel(name: "name", stars: 1, category: "cat", location: "loc", url: "url", memo: "memo", notes: []), companyVm: testCompany)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
