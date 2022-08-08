//
//  NoteEditView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct NoteView: View {
    var note: NoteModel
    
    @State var title: String = ""
    @State var text: String = ""
    
    @FocusState private var inputFocus: Bool
    
    @State private var offset = CGFloat.zero
    @State var isPresented = false
    
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        
        ZStack {
            Color(.systemGray5)
                .ignoresSafeArea()
            
            VStack {
                
                Divider()
                
                // TextEditorの上に透明なTextを載せることで、TextEditorの高さの分、View自体の大きさを大きくしてくれる
                ZStack {
                    TextEditor(text: $text)
                    // 渡されたnoteのtextを代入
                        .onAppear() {
                            self.text = note.text
                        }
                        .focused($inputFocus)
                        .font(.body)
                        .padding(.horizontal)
                    Text(text).opacity(0).padding(.all, 8)
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
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoteView(note: .init(text: "メモメモ"))
        }
    }
}
