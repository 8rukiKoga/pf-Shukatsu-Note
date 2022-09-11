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
    ) var companies: FetchedResults<Company>
    
    @FetchRequest(
        entity: Note.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.updatedAt, ascending: false)],
        predicate: nil
    ) var notes: FetchedResults<Note>
    
    @ObservedObject var companyVm: CompanyViewModel
    @ObservedObject var noteVm: NoteViewModel
    @ObservedObject var todoVm: TodoViewModel
    
    @State private var showingPopup: Bool = false
    // 新規ノート作成時
    @State private var showingNote: Bool = false
    
    var body: some View {
        NavigationView {
            // ポップアップ表示用Z
            ZStack {
                // 新規ノートに遷移
                if let sortedNote = notes.sorted { $0.createdAt ?? Date() > $1.createdAt ?? Date() } {
                    if let newNot = sortedNote.first {
                        NavigationLink("", destination: NoteView(note: newNot), isActive: $showingNote)
                    }
                }
                
                List {
                    // 表示するノートをフィルタリング
                    let globalNotes = notes.filter { $0.companyId == nil }
                    // メモリスト
                    Section {
                        ForEach(globalNotes) { note in
                            NavigationLink(destination: NoteView(note: note)) {
                                NoteRowView(text: note.text ?? "New Note")
                            }
                        }
                        .onDelete(perform: deleteNote)
                    } header: {
                        HStack {
                            Text("Note")
                            Spacer()
                            // ＊ 新しいメモを追加 後々ポップアップでtitle入力->追加ができるようにする
                            Button {
                                Note.create(in: context, companyId: nil)
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
                        ForEach(companies) { company in
                            NavigationLink(destination: CompanyView(company: company)) {
                                FolderRowView(company: company)
                            }
                        }
                        .onDelete(perform: deleteCompany)
                    } header: {
                        HStack {
                            Text("企業リスト")
                            Spacer()
                            
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
                
                // popupView
                if showingPopup {
                    AddCompanyPopupView(companyVm: companyVm, showingPopup: $showingPopup)
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

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        
        // テストデータをプレビュー表示
        
        let testCompany = CompanyViewModel()
        testCompany.companyList = sampleCompanies
        
        let testNote = NoteViewModel()
        testNote.noteList = sampleNotes
        
        return Group {
            MyNotesView(companyVm: testCompany, noteVm: testNote, todoVm: TodoViewModel())
            
            MyNotesView(companyVm: testCompany, noteVm: testNote, todoVm: TodoViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
