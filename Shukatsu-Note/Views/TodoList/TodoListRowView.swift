//
//  TodoListRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct TodoListRowView: View {
    @ObservedObject var todoVm: TodoViewModel
    var task: TodoModel
    var body: some View {
        
        if let taskIndex = todoVm.todoList.firstIndex(of: task) {
            HStack {
                Button {
                    todoVm.todoList[taskIndex].done.toggle()
                    
                } label: {
                    if todoVm.todoList[taskIndex].done {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(Color(.systemYellow))
                    } else {
                        Image(systemName: "circle")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                Text(task.name)
            }
            .padding(.horizontal)
        }
        
    }
}

struct TodoListRowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListRowView(todoVm: TodoViewModel(), task: TodoModel(name: "wawawa", done: false))
    }
}
