//
//  TodoListView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI
import CoreData
import EventKit

struct TodoListView: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Task.doneAt, ascending: true),
            NSSortDescriptor(keyPath: \Task.date, ascending: true),
            NSSortDescriptor(keyPath: \Task.createdAt, ascending: false),
        ],
        predicate: nil
    ) private var tasks: FetchedResults<Task>
    @FetchRequest(
        entity: Company.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Company.star, ascending: false),
            NSSortDescriptor(keyPath: \Company.createdAt, ascending: true)
        ],
        predicate: nil
    ) private var companies: FetchedResults<Company>
    
    var eventStore = EKEventStore()
    
    // 登録タスク数バリデーションの表示・非表示
    @State private var showingTaskCountAlert: Bool = false
    // 新規タスク追加シートの表示・非表示
    @State var showingSheet: Bool = false
    // タスク編集シートの表示・非表示
    @State var showingEditSheet: Bool = false
    
    private var company: Company?
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                List {
                    if tasks.isEmpty {
                        NoItemView(listType: .task)
                    } else {
                        ForEach(tasks) { task in
                            Button {
                                showingEditSheet = true
                            } label: {
                                TodoListRowView(task: task)
                            }
                            .fullScreenCover(isPresented: $showingEditSheet) {
                                TaskView(showingEditSheet: $showingEditSheet, task: task, taskName: task.name ?? "", date: task.date ?? Date(), endDate: task.endAt ?? Date() + (60 * 30), dateIsSet: task.date != nil ? true : false, endDateIsSet: task.endAt != nil ? true : false, remindDate: task.remindAt ?? Date(), reminderIsSet: task.remindAt != nil ? true : false, companyId: companies.first(where: { $0.id == task.companyId })?.id ?? "")
                            }
                        }
                        .onDelete(perform: deleteTask)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .padding(.bottom, 80)
                
                VStack {
                    Spacer()
                    
                    Button {
                        if tasks.count < ValidationCounts.taskData.rawValue {
                            showingSheet = true
                        } else {
                            showingTaskCountAlert = true
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color(.systemGray4))
                                .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                                .shadow(color: .gray, radius: 5, x: 2, y: 2)
                            VStack {
                                Text(NSLocalizedString("Todoを追加", comment: ""))
                                    .foregroundColor(Color(.systemBackground))
                                    .bold()
                            }
                        }
                    }
                    .alert(isPresented: $showingTaskCountAlert) {
                        Alert(title: Text(String(format: NSLocalizedString("登録可能タスク数の上限(%d)に達しています。", comment: ""), ValidationCounts.taskData.rawValue)))
                    }
                }
                .padding()
                .padding(.bottom, 10)
            }
            // 新規タスク追加シート
            .sheet(isPresented: $showingSheet) {
                AddTodoView(showingSheet: $showingSheet)
            }
            .navigationTitle("Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .onAppear() {
            // 通知リクエスト
            NotificationManager.instance.requestAuth()
            
            if EKEventStore.authorizationStatus(for: .event) == .notDetermined{
                eventStore.requestAccess(to: .event, completion: { (granted, error) in
                    if granted && error == nil {
                        print("granted")
                    }
                    else{
                        print("not granted")
                    }
                })
            }
        }
    }
    
    private func deleteTask(offsets: IndexSet) {
        offsets.forEach { index in
            context.delete(tasks[index])
        }
        // 削除内容を保存
        try? context.save()
    }
}
