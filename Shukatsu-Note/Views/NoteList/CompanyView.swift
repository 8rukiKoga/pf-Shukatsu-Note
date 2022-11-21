//
//  CompanyView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI
import StoreKit

struct CompanyView: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Company.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Company.star, ascending: false),
            NSSortDescriptor(keyPath: \Company.createdAt, ascending: true)
        ],
        predicate: nil
    ) private var companies: FetchedResults<Company>
    
    @FetchRequest(
        entity: Note.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.updatedAt, ascending: false)],
        predicate: nil
    ) private var notes: FetchedResults<Note>
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Task.doneAt, ascending: true),
            NSSortDescriptor(keyPath: \Task.date, ascending: true),
            NSSortDescriptor(keyPath: \Task.createdAt, ascending: false),
        ],
        predicate: nil
    ) private var tasks: FetchedResults<Task>
    
    // キーボードの開閉制御
    @FocusState private var inputFocus: Bool
    // 編集シートの表示・非表示
    @State private var showingSheet: Bool = false
    // 新規ノート遷移
    @State var showingNote: Bool = false
    
    var company: Company
    @State private var memoText: String
    
    init(company: Company) {
        self.company = company
        self._memoText = State(initialValue: company.memo ?? "")
    }
    
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
                                    .modifier(CompanyImageMod(size: 80))
                            } else {
                                // ユーザーがまだ画像を設定していない場合
                                Image(uiImage: UIImage(named: "default-companyImage")!)
                                    .resizable()
                                    .modifier(CompanyImageMod(size: 80))
                            }
                            
                            Spacer()
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Spacer()
                            
                            Text(company.name ?? "Company")
                                .bold()
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                        }
                        
                        // フォントサイズを一括で設定するためにGroupで囲む
                        Group {
                            HStack {
                                Text(NSLocalizedString("志望度 : ", comment: ""))
                                
                                Spacer()
                                
                                Text("\(StarConvertor.shared.convertIntToStars(count: Int(company.star)))")
                                    .font(company.star != 0 ? .system(size: 18) : .system(size: 13))
                                    .foregroundColor(company.star != 0 ? Color(.systemYellow) : Color(.gray))
                                    .fontWeight(company.star != 0 ? .bold : .none)
                            }
                            .padding(.top, 10)
                            .padding(1)
                            
                            HStack {
                                Text(NSLocalizedString("業界 : ", comment: ""))
                                
                                Spacer()
                                
                                Text(company.category ?? "")
                            }
                            .padding(1)
                            
                            HStack {
                                Text(NSLocalizedString("所在地 : ", comment: ""))
                                
                                Spacer()
                                
                                Text(company.location ?? "")
                            }
                            .padding(1)
                            
                            HStack {
                                Text("URL")
                                
                                Spacer()
                                
                                if let companyUrl = company.url {
                                    if companyUrl.isEmpty {
                                        Text("")
                                    } else if VerifyUrl.shared.verifyUrl(urlString: companyUrl) {
                                        Text(companyUrl)
                                            .foregroundColor(Color(.link))
                                            .font(.caption)
                                            .onTapGesture {
                                                UrlOpener.shared.openUrl(url: companyUrl)
                                            }
                                    } else {
                                        Text(companyUrl)
                                            .strikethrough()
                                            .foregroundColor(.gray)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                        .font(.system(size: 15))
                    }
                    .padding()
                } header: {
                    HStack {
                        Text(NSLocalizedString("企業情報", comment: ""))
                        
                        Spacer()
                        
                        Button {
                            // 企業編集画面を開く
                            showingSheet = true
                        } label: {
                            Image(systemName: "gearshape.circle.fill")
                                .font(.system(size: 22))
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
                            .onChange(of: memoText) { newValue in
                                // ＊原因不明：たまに特定のメモで、入力動作が遅いものがある
                                saveMemo(text: newValue)
                            }
                        
                        if memoText.isEmpty {
                            VStack {
                                HStack {
                                    Text(NSLocalizedString("すぐに見たい情報をここに書きます。\n選考フローやマイページのID・パスワードなど", comment: ""))
                                        .opacity(0.25)
                                        .font(.caption)
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                            }
                            .padding()
                        }
                    }
                } header: {
                    Text("Memo")
                }
                .textCase(nil)
                
                Section {
                    // 表示するタスクをフィルタリング
                    let companyTasks = tasks.filter { $0.companyId == company.id }
                    if companyTasks.isEmpty {
                        HStack {
                            Spacer()
                            
                            Text(NSLocalizedString("この企業に関連したタスクはありません✔️", comment: ""))
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .opacity(0.6)
                            Spacer()
                        }
                    } else {
                        ForEach(companyTasks) { task in
                            TodoListRowView(task: task)
                        }
                    }
                } header: {
                    Text("Todo")
                }
                .textCase(nil)
                
                Section {
                    // 表示するノートをフィルタリング
                    let companyNotes = notes.filter { $0.companyId == company.id }
                    if companyNotes.isEmpty {
                        NoItemView(listType: .note)
                    } else {
                        ForEach(companyNotes) { note in
                            NavigationLink(destination: NoteView(note: note)) {
                                NoteRowView(text: note.text ?? "New Note")
                            }
                        }
                        .onDelete(perform: deleteNote)
                    }
                } header: {
                    ListHeader(showingSomething: $showingNote, listType: .companyNote, companyId: company.id ?? "", noteCount: notes.count)
                }
                .textCase(nil)
                
            }
            .listStyle(InsetGroupedListStyle())
            .gesture(
                // 下にドラッグした時に、キーボードを閉じる
                DragGesture().onChanged({ value in
                    if value.translation.height > 0 {
                        inputFocus = false
                    }
                })
            )
            .navigationTitle(company.name ?? "Company")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .onAppear() {
            let mainView = MainView()
            if mainView.isInitialLaunch == false {
                // 1/50の確率で、レビュー依頼ポップアップを表示
                let randomInt = Int.random(in: 1..<50)
                if randomInt == 1 {
                    if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                }
            }
        }
        
    }
    
    private func saveMemo(text: String) {
        Company.updateMemo(in: context, currentCompany: company, memo: memoText)
    }
    
    private func deleteNote(offsets: IndexSet) {
        // 企業ノートに絞り込む
        let companyNotes = notes.filter { $0.companyId == company.id }
        
        offsets.forEach { index in
            // 企業ノートでのインデックス要素を消す
            context.delete(companyNotes[index])
        }
        // 削除内容を保存
        try? context.save()
    }
    
}
