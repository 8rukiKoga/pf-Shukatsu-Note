//
//  TodoListRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct TodoListRowView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    private let dateFormatter = DateFormatter()
    
    var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    var body: some View {
        
        HStack {
            
            Image(systemName: task.done ? "checkmark.circle.fill" : "circle")
                .font(task.done ? .title2 : .title)
                .foregroundColor(task.done ? Color(.systemGreen) : .gray)
                .onTapGesture {
                    withAnimation {
                        Task.updateStatus(in: context, task: task)
                    }
                    // バイブレーション
                    VibrationGenerator.vibGenerator.notificationOccurred(.success)
                }
                .padding(.trailing, 3)
            
            VStack(alignment: .leading) {
                HStack {
                    if let taskDate = task.date {
                        Text(CustomDateFormatter.shared.convertDateToString(from: taskDate))
                            .font(.system(size: 12))
                            .padding(.trailing, 1)
                    }
                    
                    if let companyName = task.companyName {
                        Text("-\(companyName)-")
                            .font(.system(size: 10))
                    }
                }
                .foregroundColor(.gray)
                
                if task.done {
                    Text(task.name ?? "")
                        .strikethrough()
                        .foregroundColor(.gray)
                        .padding(.vertical, 1)
                    // 文字が...で省略されないようにする
                        .fixedSize(horizontal: false, vertical: true)
                } else {
                    Text(task.name ?? "")
                        .padding(.vertical, 1)
                    // 文字が...で省略されないようにする
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(.horizontal)
        
    }
}
