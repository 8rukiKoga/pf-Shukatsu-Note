//
//  TodoListRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct TodoListRowView: View {
    @ObservedObject var todoVm: TodoViewModel
    // フォルダからの遷移かどうか検知
    var isInFolder: Bool = false
    var task: TodoModel
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        if let taskIndex = todoVm.todoList.firstIndex(of: task) {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.name)
                        .padding(.vertical, 1)
                        // 文字が...で省略されないようにする
                        .fixedSize(horizontal: false, vertical: true)
                    if task.dateIsSet {
                        Text(CustomDateFormatter.shared.convertDateToString(from: task.date!))
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                            .padding(.leading, 2)
                    }
                }
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
            .previewLayout(.sizeThatFits)
    }
}
