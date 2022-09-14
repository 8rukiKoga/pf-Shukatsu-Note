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
    // 新規企業企業のポップアップの表示・非表示
    @State private var showingPopup: Bool = false
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
                        HStack {
                            Text("Note")
                            
                            Spacer()
                            // 新規ノート作成ボタン
                            Button {
                                Note.create(in: context, companyId: nil)
                                // 新規ノートに遷移する
                                showingNote.toggle()
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .font(.system(size: 15))
                            }
                            .padding(.trailing, 5)
                        }
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
                        HStack {
                            Text("企業リスト")
                            
                            Spacer()
                            // 新規ノート作成ボタン
                            Button {
                                // ポップアップ表示
                                withAnimation {
                                    showingPopup = true
                                }
                            } label: {
                                Image(systemName: "folder.badge.plus")
                                    .font(.system(size: 15))
                            }
                            .padding(.trailing, 5)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                // 新規企業追加ポップアップ
                if showingPopup {
                    AddCompanyPopupView(showingPopup: $showingPopup)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        
    }
    private func deleteNote(offsets: IndexSet) {
        
        offsets.forEach { index in
            context.delete(notes[index])
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
