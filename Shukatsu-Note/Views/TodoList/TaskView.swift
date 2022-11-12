//
//  TaskView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/11/12.
//

import SwiftUI

struct TaskView: View {
    
    @FetchRequest(
        entity: Company.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Company.star, ascending: false)],
        predicate: nil
    ) private var companies: FetchedResults<Company>
    
    @State private var taskName: String = "説明会"
    @State private var date: Date = Date()
    @State private var dateIsSet: Bool = true
    @State private var company: String = "さんぷるカンパニー"
    
    @State private var notificationBtnText: String = NSLocalizedString("当日に通知する", comment: "")
    
    @State private var reminderIsSet: Bool = false
    @State private var showingReminderAlert: Bool = false
    
    //    var task: Task
    //
    //    init(task: Task) {
    //        self.task = task
    //    }
    
    var body: some View {
        List {
            Section(NSLocalizedString("ステータス", comment: "")) {
                HStack {
                    Spacer()
                    Text(dateIsSet ? "DONE" : "NOT DONE")
                        .foregroundColor(dateIsSet ? .green : .red)
                    Spacer()
                }
                .listRowBackground(dateIsSet ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                .padding()
            }
            
            Section(NSLocalizedString("タスク名", comment: "")) {
                VStack {
                    TextField(NSLocalizedString("タスク名を入力", comment: ""), text: $taskName)
                        .padding(10)
                        .background(Color(.systemGray5))
                        .cornerRadius(7)
                    
                    Text("\(taskName.count) / 50")
                        .font(.caption2)
                        .foregroundColor(TextCountValidation.shared.isTextCountValid(text: taskName, max: 50) ? .gray : .red)
                        .padding(.bottom)
                }
            }
            
            
            Section(NSLocalizedString("日付", comment: "")) {
                HStack {
                    Text(NSLocalizedString("日付", comment: ""))
                    
                    Toggle("", isOn: $dateIsSet)
                        .animation(.easeInOut, value: dateIsSet)
                    if dateIsSet {
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .cornerRadius(7)
                            .transition(.slide)
                    } else {
                        Text(NSLocalizedString("日付未指定", comment: ""))
                            .foregroundColor(.gray)
                            .transition(.slide)
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            notificationBtnText = NSLocalizedString("当日の0時にお知らせします", comment: "")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                notificationBtnText = "リマインダーを解除"
                            }
                        }
                    } label: {
                        Text(notificationBtnText)
                    }
                    .alert(isPresented: $showingReminderAlert) {
                        Alert(title: Text(NSLocalizedString("リマインダーを解除", comment: "")),
                              message: Text(NSLocalizedString("このタスクのリマインダーを解除しますか？", comment: "")),
                              primaryButton: .default(Text("OK"), action: {
                            // 通知キャンセル
                        }),
                              secondaryButton: .cancel(Text("Cancel"))
                        )
                    }
                }
            }
            
            Section(NSLocalizedString("企業", comment: "")) {
                HStack {
                    Text(NSLocalizedString("企業", comment: ""))
                        .font(.footnote)
                        .padding(.trailing, 3)
                        .frame(height: 40)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Task")
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
