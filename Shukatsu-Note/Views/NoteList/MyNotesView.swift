//
//  MyListView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct MyNotesView: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Company.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Company.star, ascending: false)],
        predicate: nil
    ) private var companies: FetchedResults<Company>
    
    @FetchRequest(
        entity: Note.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.updatedAt, ascending: false)],
        predicate: nil
    ) private var notes: FetchedResults<Note>
    // テーマカラー呼び出し
    @EnvironmentObject private var customColor: CustomColor
    // 新規企業企業のポップアップの表示・非表示
    @State private var showingPopup: Bool = false
    // 新規企業企業のポップアップの表示・非表示
    @State private var showingCompanyCountAlert: Bool = false
    // 新規ノートに遷移するかどうか
    @State private var showingNote: Bool = false
    
    var body: some View {
        
        NavigationView {
            // 新規企業追加ポップアップの表示用のZStack
            ZStack {
                // 新規ノートに遷移
                // notesを作成日時順に並び替えて、一番新しいものに遷移する
                if let sortedNote = notes.sorted { $0.createdAt ?? Date() > $1.createdAt ?? Date() } {
                    if let newNote = sortedNote.first {
                        NavigationLink("", destination: NoteView(note: newNote), isActive: $showingNote)
                    }
                }
                
                List {
                    // ノートリスト
                    Section {
                        // 表示するノートをフィルタリング
                        let globalNotes = notes.filter { $0.companyId == nil }
                        if globalNotes.isEmpty {
                            NoItemView(listType: .note)
                        } else {
                            ForEach(globalNotes) { note in
                                NavigationLink(destination: NoteView(note: note)) {
                                    NoteRowView(text: note.text ?? "New Note")
                                }
                            }
                            .onDelete(perform: deleteNote)
                        }
                    } header: {
                        ListHeader(showingSomething: $showingNote, listType: .note, noteCount: notes.count)
                    }
                    .textCase(nil)
                    
                    // 企業リスト
                    Section {
                        if companies.isEmpty {
                            NoItemView(listType: .company)
                        } else {
                            ForEach(companies) { company in
                                NavigationLink(destination: CompanyView(company: company)) {
                                    FolderRowView(companyImage: company.image, name: company.name ?? "", star: Int(company.star))
                                }
                            }
                            .onDelete(perform: deleteCompany)
                        }
                    } header: {
                        ListHeader(showingSomething: $showingPopup, listType: .company, companyCount: companies.count)
                    }
                    .textCase(nil)
                    
                }
                .listStyle(PlainListStyle())
                
                // 新規企業追加ポップアップ
                if showingPopup {
                    AddCompanyPopupView(showingPopup: $showingPopup)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        
    }
    private func deleteNote(offsets: IndexSet) {
        // グローバルノートに絞り込む
        let globalNotes = notes.filter { $0.companyId == nil }
        
        offsets.forEach { index in
            // グローバルノートでのインデックス要素を消す
            context.delete(globalNotes[index])
        }
        // 削除内容を保存
        try? context.save()
    }
    
    private func deleteCompany(offsets: IndexSet) {
        offsets.forEach { index in
            context.delete(companies[index])
        }
        // 削除内容を保存
        try? context.save()
    }
}
