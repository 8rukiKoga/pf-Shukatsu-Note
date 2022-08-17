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
                Text(task.name)
                Spacer()
                
                Button {
                    withAnimation {
                        todoVm.todoList[taskIndex].done.toggle()
                    }
                } label: {
                    Image(systemName: todoVm.todoList[taskIndex].done ? "checkmark.circle.fill" : "circle")
                        .font(todoVm.todoList[taskIndex].done ? .title2 : .title3)
                        .foregroundColor(todoVm.todoList[taskIndex].done ? Color(.systemGreen) : .gray)
                }
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
