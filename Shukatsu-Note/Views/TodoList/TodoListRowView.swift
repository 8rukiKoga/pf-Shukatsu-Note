//
//  TodoListRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct TodoListRowView: View {
    @ObservedObject var todoVm: TodoViewModel
    var companyName: String?
    var task: Task
    
    let dateFormatter = DateFormatter()
    
    var body: some View {

            HStack {
                VStack(alignment: .leading) {
                    if task.date != nil {
                        HStack {
                            Text(CustomDateFormatter.shared.convertDateToString(from: task.date!))
                                .font(.system(size: 12))
                            if let companyName = companyName {
                                Text("-\(companyName)-")
                                    .font(.system(size: 10))
                                    .padding(.leading, 1)
                            }
                        }
                        .foregroundColor(.gray)
                    }
                    
                    Text(task.name ?? "")
                        .padding(.vertical, 1)
                    // 文字が...で省略されないようにする
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                
                Button {
                    withAnimation {
//                        task.done.toggle()
                    }
                } label: {
                    Image(systemName: task.done ? "checkmark.circle.fill" : "circle")
                        .font(task.done ? .title2 : .title3)
                        .foregroundColor(task.done ? Color(.systemGreen) : .gray)
                }
            }
            .padding(.horizontal)
        
    }
}

//struct TodoListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListRowView(todoVm: TodoViewModel(), task: TodoModel(name: "wawawa", done: false))
//            .previewLayout(.sizeThatFits)
//    }
//}
