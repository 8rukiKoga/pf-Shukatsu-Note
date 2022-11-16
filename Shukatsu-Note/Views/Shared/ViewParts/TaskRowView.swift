//
//  TodoListRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct TodoListRowView: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Company.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Company.star, ascending: false),
            NSSortDescriptor(keyPath: \Company.createdAt, ascending: true)
        ],
        predicate: nil
    ) private var companies: FetchedResults<Company>
    
    private let dateFormatter = DateFormatter()
    
    var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    var body: some View {
        
        HStack {
            
            Image(systemName: task.done ? "checkmark.circle.fill" : "circle")
                .font(task.done ? .system(size: 25): .system(size: 30))
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
                if let companyName = companies.first(where: { $0.id == task.companyId })?.name {
                    Text("-\(companyName)-")
                        .font(.system(size: 8))
                        .padding(.bottom, 1)
                }
                
                HStack() {
                    if let taskDate = task.date {
                        Image(systemName: "calendar.circle")
                            .font(.system(size: 9))
                        Text(CustomDateFormatter.shared.convertDateToString(from: taskDate))
                            .font(.system(size: 10))
                            .padding(.trailing, 1)
                    }
                    
                    if let reminderTime = task.remindAt {
                        Divider()
                        
                        Image(systemName: "bell.circle")
                            .font(.system(size: 9))
                        Text(CustomDateFormatter.shared.convertTimeToString(from: reminderTime))
                            .font(.system(size: 10))
                            .padding(.trailing, 1)
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
            
            Spacer()
        }
        
    }
}
