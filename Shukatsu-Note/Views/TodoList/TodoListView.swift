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
    ) private var tasks: FetchedResults<Task>
    // 新規タスク追加シートの表示・非表示
    @State var showingSheet: Bool = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                List {
                    if tasks.isEmpty {
                        NoItemView(listType: .task)
                    } else {
                        ForEach(tasks) { task in
                            TodoListRowView(task: task)
                        }
                        .onDelete(perform: deleteTask)
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.bottom, 80)
                
                VStack {
                    Spacer()
                    
                    Button {
                        showingSheet = true
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color(CustomColor.customBrown))
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
    }
    
    private func deleteTask(offsets: IndexSet) {
        offsets.forEach { index in
            context.delete(tasks[index])
        }
        // 削除内容を保存
        try? context.save()
    }
}
