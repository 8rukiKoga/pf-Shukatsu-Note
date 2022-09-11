//
//  NoteEditView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct NoteView: View {
    @Environment(\.managedObjectContext) private var context
    
    var company: CompanyModel?
    var note: Note
    var companyIndex: Int?
    
    @State var text: String
    
    @FocusState private var inputFocus: Bool
    
    init(note: Note) {
        self.note = note
        self._text = State(initialValue: note.text ?? "")
    }
    
    var body: some View {
        
        // 背景色
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack {
                
                Divider()
                
                ZStack {
                    TextEditor(text: $text)
                    // 渡されたnoteのtextを代入
                        .focused($inputFocus)
                        .font(.body)
                        .padding(.horizontal)
                        .onChange(of: text) { newValue in
                            saveNote()
                        }
                    // TextEditorの上に透明なTextを載せることで、TextEditorの高さの分、View自体の大きさを大きくしてくれる
                    Text(text)
                        .opacity(0)
                        .padding(8)
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
    
    private func saveNote() {
        note.text = text
        try? context.save()
    }
}

//struct NoteView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let testCompany = CompanyViewModel()
//        testCompany.companyList = sampleCompanies
//
//        let testNote = NoteViewModel()
//        testNote.noteList = sampleNotes
//
//        return NavigationView {
//            NoteView(isInFolder: true, note: NoteModel(text: "This is text"), companyVm: testCompany, noteVm: testNote)
//        }
//    }
//}
