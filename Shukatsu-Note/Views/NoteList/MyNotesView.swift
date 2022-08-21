//
//  MyListView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct MyNotesView: View {
    
    @ObservedObject var companyVm: CompanyViewModel
    @ObservedObject var noteVm: NoteViewModel
    
    @State private var showingPopup: Bool = false
    
    var body: some View {
        // ポップアップ表示用Z
        ZStack {
            NavigationView {
                
                List {
                    // メモリスト
                    Section {
                        ForEach(noteVm.noteList) { note in
                            NavigationLink(destination: NoteView(isInFolder: false, note: note, companyVm: companyVm, noteVm: noteVm)) {
                                NoteRowView(companyVm: companyVm, noteVm: noteVm, isInFolder: false, note: note)
                            }
                        }
                        // editbuttonの動作
                        .onMove { (indexSet, index) in
                            noteVm.noteList.move(fromOffsets: indexSet, toOffset: index)
                        }
                        .onDelete { indexSet in
                            noteVm.noteList.remove(atOffsets: indexSet)
                        }
                    } header: {
                        HStack {
                            Text("Note")
                            Spacer()
                            // ＊ 新しいメモを追加 後々ポップアップでtitle入力->追加ができるようにする
                            Button {
                                noteVm.noteList.append(NoteModel(text: "New Note"))
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
                        ForEach(companyVm.companyList) { company in
                            NavigationLink(destination: CompanyView(company: company, companyVm: companyVm)) {
                                FolderRowView(company: company)
                            }
                        }
                        // editbuttonの動作
                        .onDelete { indexSet in
                            companyVm.deleteCompany(indexSet: indexSet)
                        }
                    } header: {
                        HStack {
                            Text("企業リスト")
                            Spacer()
                            
                            Button {
                                print("sort")
                            } label: {
                                Image(systemName: "square.3.stack.3d")
                                    .font(.system(size: 15))
                            }
                            .padding(.trailing, 10)
                            
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
                
                .navigationTitle("Notes")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
            // popupView
            if showingPopup {
                AddCompanyPopupView(companyVm: companyVm, showingPopup: $showingPopup)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            
        }
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
            MyNotesView(companyVm: testCompany, noteVm: testNote)
            
            MyNotesView(companyVm: testCompany, noteVm: testNote)
                .preferredColorScheme(.dark)
        }
    }
}
