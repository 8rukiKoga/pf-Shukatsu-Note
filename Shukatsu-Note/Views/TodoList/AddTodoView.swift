//
//  AddTodoView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct AddTodoView: View {
    
    @ObservedObject var todoVm: TodoViewModel
    
    @Binding var showSheet: Bool
    @State var taskName: String = ""
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button {
                    showSheet = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                }
                .padding(6)
            }
            Spacer()
            
            TextField("タスク名を入力", text: $taskName)
                .padding()
                .frame(width: screenWidth - 50)
                .background(Color(.systemGray5))
                .padding(.bottom)
            
            Button {
                todoVm.addTodo(name: taskName)
                showSheet = false
            } label: {
                Text("追加")
                    .font(.title3).bold()
                    .foregroundColor(Color(.systemBackground))
                    .frame(width: screenWidth - 200, height: 15)
                    .padding()
                    .background(Color(.systemBlue))
                    .cornerRadius(5)
            }
            Spacer()
        }
        .padding()
        
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(todoVm: TodoViewModel(), showSheet: .constant(true))
    }
}
