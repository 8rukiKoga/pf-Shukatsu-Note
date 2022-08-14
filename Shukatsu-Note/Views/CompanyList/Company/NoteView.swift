//
//  NoteEditView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct NoteView: View {
    // フォルダ内にあるノートか、またはMainViewに表示するノートか
    var isInFolder: Bool
    
    var company: CompanyModel?
    var note: NoteModel
    var companyIndex: Int?
    
    @ObservedObject var companyVm: CompanyViewModel
    @ObservedObject var noteVm: NoteViewModel
    
    @FocusState private var inputFocus: Bool
    
    @State private var offset = CGFloat.zero
    @State var isPresented = false
    
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        
        // 背景色
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack {
                
                Divider()
                
                // TextEditorの上に透明なTextを載せることで、TextEditorの高さの分、View自体の大きさを大きくしてくれる
                ZStack {
                    // 企業フォルダ内にあるノートの場合
                    if isInFolder {
                        if let noteIndex = companyVm.companyList[companyIndex!].notes.firstIndex(of: note) {
                            TextEditor(text: $companyVm.companyList[companyIndex!].notes[noteIndex].text)
                            // 渡されたnoteのtextを代入
                                .focused($inputFocus)
                                .font(.body)
                                .padding(.horizontal)
                                .onAppear() {
                                    if companyVm.companyList[companyIndex!].notes[noteIndex].text == "New Note" {
                                        companyVm.companyList[companyIndex!].notes[noteIndex].text = ""
                                    }
                                }
                            
                            Text(companyVm.companyList[companyIndex!].notes[noteIndex].text)
                                .opacity(0)
                                .padding(8)
                        }
                    }
                    // MainViewにあるノートの場合
                    else {
                        if let noteIndex = noteVm.noteList.firstIndex(of: note) {
                            TextEditor(text: $noteVm.noteList[noteIndex].text)
                            // 渡されたnoteのtextを代入
                                .focused($inputFocus)
                                .font(.body)
                                .padding(.horizontal)
                                .onAppear() {
                                    if noteVm.noteList[noteIndex].text == "New Note" {
                                        noteVm.noteList[noteIndex].text = ""
                                    }
                                }
                            
                            Text(noteVm.noteList[noteIndex].text)
                                .opacity(0)
                                .padding(8)
                        }
                    }
                }
                
            }
            // テキストエディタの色を消す・つける
            .onAppear() {
                UITextView.appearance().backgroundColor = .clear
            }.onDisappear() {
                UITextView.appearance().backgroundColor = nil
            }
            .gesture(
                DragGesture().onChanged({ value in
                    if value.translation.height > 0 {
                        inputFocus = false
                    }
                })
            )
            .onTapGesture(perform: {
                inputFocus = true
            })
            
            .navigationTitle("Note")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        
        let testCompany = CompanyViewModel()
        testCompany.companyList = sampleCompanies
        
        let testNote = NoteViewModel()
        testNote.noteList = sampleNotes
        
        return NavigationView {
            NoteView(isInFolder: true, note: NoteModel(text: "This is text"), companyVm: testCompany, noteVm: testNote)
        }
    }
}
