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
    @ObservedObject var todoVm: TodoViewModel
    
    // キーボードの開閉制御
    @FocusState private var inputFocus: Bool
    // 編集シート開閉制御
    @State private var showingSheet: Bool = false
    
    var body: some View {
        
        List {
            Section {
                VStack(alignment: .leading) {
                    // ＊ 後々アイコンまたは画像を適用・変更できるようにする。
                    HStack {
                        Spacer()
                        if let companyIndex = companyVm.companyList.firstIndex(of: company) {
                            if let imageData = companyVm.companyList[companyIndex].image {
                                Image(uiImage: UIImage(data: imageData)!)
                                    .resizable()
                                    .modifier(CompanyImageMod())
                            } else {
                                Image(uiImage: UIImage(named: "default-companyImage2")!)
                                    .resizable()
                                    .modifier(CompanyImageMod())
                            }
                        }
                        Spacer()
                    }
                    // ＊ もっとコードを綺麗にできそう(?)
                    HStack {
                        Text("志望度 : ")
                            .font(.system(size: 15))
                        Spacer()
                        Text("\(ConvertIntToStars(count: company.stars))")
                            .font(StarsAreSet(stars: company.stars) ? .system(size: 18) : .system(size: 15))
                            .foregroundColor(StarsAreSet(stars: company.stars) ? Color(.systemYellow) : Color(.gray))
                            .fontWeight(StarsAreSet(stars: company.stars) ? .bold : .none)
                    }
                    .padding(.top, 10)
                    .padding(1)
                    HStack {
                        Text("業界 : ")
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
                        // URLが有効かどうか確認してから表示する
                        if verifyUrl(urlString: company.url) {
                            let markdownLink = try! AttributedString(markdown: "[\(company.url)](\(company.url))")
                            Text(markdownLink)
                                .padding(1)
                        }
                    }
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
                        if let companyIndex = companyVm.companyList.firstIndex(of: company) {
                            // ユーザーがimageを設定している場合はそのUIImageを渡す
                            if let imageData = companyVm.companyList[companyIndex].image {
                                EditCompanyView(showingSheet: $showingSheet, companyVm: companyVm, company: company, companyImage: UIImage(data: imageData)!, name: company.name, stars: company.stars, category: company.category, location: company.location, url: company.url)
                            } else {
                                EditCompanyView(showingSheet: $showingSheet, companyVm: companyVm, company: company, name: company.name, stars: company.stars, category: company.category, location: company.location, url: company.url)
                            }
                        }
                    })
                }
            }
            .textCase(nil)
            
            // 企業インデックス特定
            if let companyIndex = companyVm.companyList.firstIndex(of: company) {
                
                Section {
                    // 簡易メモ
                    ZStack {
                        TextEditor(text: $companyVm.companyList[companyIndex].memo)
                            .padding(.horizontal, 2)
                            .frame(height: 100)
                            .background(Color(.systemGray5))
                            .cornerRadius(3)
                            .focused($inputFocus)
                            .font(.caption)
                            .padding(8)
                        
                        if companyVm.companyList[companyIndex].memo.isEmpty {
                            VStack {
                                HStack {
                                    Text("すぐに見たい情報をここに書きます。\n選考フローやマイページのID・パスワードなど")
                                        .opacity(0.25)
                                        .font(.caption)
                                    
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
                // companyからtodoを参照したいが、なぜかできない
//                Section() {
//                    ForEach(companyVm.companyList[companyIndex].todos) { task in
//                        TodoListRowView(todoVm: todoVm, task: task)
//                    }
//                } header: {
//                    Text("Todo")
//                }
//                .textCase(nil)
                
                Section {
                    ForEach(companyVm.companyList[companyIndex].notes) { note in
                        NavigationLink(destination: NoteView(isInFolder: true, note: note, companyIndex: companyIndex, companyVm: companyVm, noteVm: NoteViewModel())) {
                            NoteRowView(companyVm: companyVm, noteVm: NoteViewModel(), isInFolder: true, companyIndex: companyIndex, note: note)
                        }
                    }
                    // なぜか使用できない
                    //                    .onMove { (indexSet, index) in
                    //                        companyVm.moveNote(companyIndex: companyIndex, from: indexSet, to: index)
                    //                    }
                    //                    .onDelete { indexSet in
                    //                        companyVm.deleteNote(companyIndex: companyIndex, indexSet: indexSet)
                    //                    }
                } header: {
                    HStack {
                        Text("Note")
                        Spacer()
                        // 新規メモボタン
                        Button {
                            companyVm.companyList[companyIndex].notes.append(NoteModel(text: "New Note"))
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
        // company内のonMove, onDeleteが使用できないためコメントアウト
        //        .toolbar {
        //            ToolbarItemGroup(placement: .navigationBarTrailing) {
        //                EditButton()
        //            }
        //        }
    }
    // URLが有効かどうか判断
    private func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
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
                CompanyView(company: CompanyModel(name: "name", stars: 1, category: "cat", location: "loc", url: "url", memo: "memo", notes: []), companyVm: testCompany, todoVm: TodoViewModel())
            }
            NavigationView {
                CompanyView(company: CompanyModel(name: "name", stars: 1, category: "cat", location: "loc", url: "url", memo: "memo", notes: []), companyVm: testCompany, todoVm: TodoViewModel())
                    .preferredColorScheme(.dark)
            }
        }
    }
}
