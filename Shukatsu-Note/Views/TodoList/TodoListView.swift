//
//  TodoListView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI
import CoreData

struct TodoListView: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.createdAt, ascending: false)],
        predicate: nil
    ) var tasks: FetchedResults<Task>
    
    @ObservedObject var todoVm: TodoViewModel
    @ObservedObject var companyVm: CompanyViewModel
    @State var showSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                if tasks.isEmpty {
                    VStack {
                        Spacer()
                        Text("No Tasks")
                            .font(.caption)
                            .padding(.bottom)
                        // No Tasksテキストを上に移動させるために下にアイテムを置く
                        Text("_")
                            .opacity(0)
                        Spacer()
                    }
                }
                else {
                    List {
                        ForEach(tasks) { task in
                            if let companyName = task.companyName {
                                TodoListRowView(todoVm: todoVm, companyName: companyName, task: task)
                            } else {
                                TodoListRowView(todoVm: todoVm, task: task)
                            }
                        }
                        .onDelete(perform: deleteTask)
                    }
                    .listStyle(PlainListStyle())
                }
                
                VStack {
                    Spacer()
                    Button {
                        showSheet = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color(.systemBrown))
                                .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                                .shadow(color: .gray, radius: 5, x: 2, y: 2)
                            VStack {
                                Text("Todoを追加")
                                    .foregroundColor(Color(.systemBackground))
                                    .bold()
                            }
                        }
                    }
                }
                .padding()
                .padding(.bottom, 10)
            }
            .sheet(isPresented: $showSheet) {
                AddTodoView(todoVm: todoVm, companyVm: companyVm, showSheet: $showSheet)
            }
            .navigationTitle("Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
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

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todoVm: TodoViewModel(), companyVm: CompanyViewModel())
    }
}
