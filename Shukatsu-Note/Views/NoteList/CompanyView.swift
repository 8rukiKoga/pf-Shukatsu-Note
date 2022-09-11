//
//  CompanyView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct CompanyView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Company.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Company.star, ascending: false)],
        predicate: nil
    ) var companies: FetchedResults<Company>
    
    @FetchRequest(
        entity: Note.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.updatedAt, ascending: false)],
        predicate: nil
    ) var notes: FetchedResults<Note>
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.createdAt, ascending: false)],
        predicate: nil
    ) var tasks: FetchedResults<Task>
    
    var company: Company
    init(company: Company) {
        self.company = company
    }
    
    @State var memoText: String = ""
    
    // キーボードの開閉制御
    @FocusState private var inputFocus: Bool
    // 編集シート開閉制御
    @State private var showingSheet: Bool = false
    // 新規ノート遷移
    @State var showingNote: Bool = false
    
    var body: some View {
        
        ZStack {
            // 新規ノートに遷移
            if let sortedNote = notes.sorted { $0.createdAt ?? Date() > $1.createdAt ?? Date() } {
                if let newNote = sortedNote.first {
                    NavigationLink("", destination: NoteView(note: newNote), isActive: $showingNote)
                }
            }
            
            List {
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            if let imageData = company.image {
                                // ユーザーが画像を設定している場合
                                Image(uiImage: UIImage(data: imageData)!)
                                    .resizable()
                                    .modifier(CompanyImageMod())
                            } else {
                                // ユーザーがまだ画像を設定していない場合
                                Image(uiImage: UIImage(named: "default-companyImage2")!)
                                    .resizable()
                                    .modifier(CompanyImageMod())
                            }
                            
                            Spacer()
                        }
                        
                        // フォントサイズを一括で設定するためにGroupで囲む
                        Group {
                            HStack {
                                Text("志望度 : ")
                                Spacer()
                                Text("\(StarConvertor.shared.convertIntToStars(count: Int(company.star)))")
                                    .font(company.star != 0 ? .system(size: 18) : .system(size: 15))
                                    .foregroundColor(company.star != 0 ? Color(.systemYellow) : Color(.gray))
                                    .fontWeight(company.star != 0 ? .bold : .none)
                            }
                            .padding(.top, 10)
                            .padding(1)
                            HStack {
                                Text("業界 : ")
                                Spacer()
                                Text(company.category ?? "未設定")
                            }
                            .padding(1)
                            HStack {
                                Text("所在地 : ")
                                Spacer()
                                Text(company.location ?? "未設定")
                            }
                            .padding(1)
                            HStack {
                                Text("URL : ")
                                Spacer()
                                // URLが有効かどうか確認してから表示する
                                if verifyUrl(urlString: company.url) {
                                    let markdownLink = try! AttributedString(markdown: "[\(company.url)](\(company.url))")
                                    Text(markdownLink)
                                        .font(.caption)
                                } else {
                                    // ＊404ページに飛ばすかなんかの処理を書く
                                }
                            }
                        }
                        .font(.system(size: 15))
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
                            //  ユーザーがimageを設定している場合はそのUIImageを渡す
                            if let imageData = company.image {
                                EditCompanyView(showingSheet: $showingSheet, company: company, companyImage: UIImage(data: imageData)!, name: company.name ?? "", star: Int(company.star), category: company.category ?? "", location: company.location ?? "", url: company.url ?? "")
                            } else {
                                EditCompanyView(showingSheet: $showingSheet, company: company, name: company.name ?? "", star: Int(company.star), category: company.category ?? "", location: company.location ?? "", url: company.url ?? "")
                            }
                            
                        })
                    }
                }
                .textCase(nil)
                
                // 企業インデックス特定
                Section {
                    // 簡易メモ
                    ZStack {
                        TextEditor(text: $memoText)
                            .padding(.horizontal, 2)
                            .frame(height: 100)
                            .background(Color(.systemGray5))
                            .cornerRadius(3)
                            .focused($inputFocus)
                            .font(.caption)
                            .padding(8)
                        
                        if memoText.isEmpty {
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
                
                //                let todos = todoVm.todoList.filter { $0.companyID == company.id }
                
                Section {
                    ForEach(tasks) { task in
                        //                            TodoListRowView(todoVm: todoVm, task: task)
                    }
                } header: {
                    Text("Todo")
                }
                .textCase(nil)
                
                //                    let notes = noteVm.noteList.filter { $0.companyID == company.id }
                
                Section {
                    ForEach(notes) { note in
                        NavigationLink(destination: NoteView(note: note)) {
                            NoteRowView(text: note.text ?? "New Note")
                        }
                    }
                } header: {
                    HStack {
                        Text("Note")
                        Spacer()
                        // 新規メモボタン
                        Button {
                            Note.create(in: context, companyId: company.id)
                            showingNote.toggle()
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 15))
                        }
                    }
                }
                .textCase(nil)
                
                
            }
            .listStyle(InsetGroupedListStyle())
            .gesture(
                DragGesture().onChanged({ value in
                    if value.translation.height > 0 {
                        inputFocus = false
                    }
                })
            )
            .navigationTitle(company.name ?? "")
        }
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

//struct CompanyView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let testCompany = CompanyViewModel()
//        testCompany.companyList = sampleCompanies
//
//        let testNote = NoteViewModel()
//        testNote.noteList = sampleNotes
//
//        return Group {
//            NavigationView {
//                CompanyView(company: CompanyModel(name: "name", stars: 1, category: "cat", location: "loc", url: "url", memo: "memo"), companyVm: testCompany, noteVm: NoteViewModel(), todoVm: TodoViewModel())
//            }
//            NavigationView {
//                CompanyView(company: CompanyModel(name: "name", stars: 1, category: "cat", location: "loc", url: "url", memo: "memo"), companyVm: testCompany, noteVm: NoteViewModel(), todoVm: TodoViewModel())
//                    .preferredColorScheme(.dark)
//            }
//        }
//    }
//}
