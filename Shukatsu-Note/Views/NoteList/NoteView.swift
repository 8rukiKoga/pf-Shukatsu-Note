//
//  NoteEditView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct NoteView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    var note: Note
    
    @State var text: String
    // キーボードを表示するかどうか
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
                            if newValue.count > 3000 {
                                text.removeLast()
                            } else {
                                // ＊原因不明：一部のノートにある文をコピペしたやつがめっちゃ遅い
                                saveNote(text: newValue)
                            }
                        }
                    // TextEditorの上に透明なTextを載せることで、TextEditorの高さの分、View自体の高さを高くしてくれる
                    Text(text)
                        .opacity(0)
                        .padding(8)
                }
            }
            .gesture(
                // 下にドラッグした時に、キーボードを閉じる
                DragGesture().onChanged({ value in
                    if value.translation.height > 0 {
                        inputFocus = false
                    }
                })
            )
            // ノートのどこかを押した時に、キーボードを開く
            .onTapGesture(perform: {
                inputFocus = true
            })
            
            .navigationTitle("Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Text("\(text.count) / 3000")
                        .font(.system(size: 8))
                        .foregroundColor(.gray)
                }
            }
        }
        
    }
    
    private func saveNote(text: String) {
        Note.update(in: context, currentNote: note, text: text)
    }
    
}
