//
//  TodoListView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct TodoListView: View {
    
    @ObservedObject var todoVm: TodoViewModel
    @State var showSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(todoVm.todoList) { task in
                        TodoListRowView(todoVm: todoVm, task: task)
                    }
                    .onMove { (indexSet, index) in
                        todoVm.todoList.move(fromOffsets: indexSet, toOffset: index)
                    }
                    .onDelete { indexSet in
                        todoVm.todoList.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(PlainListStyle())
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            showSheet = true
                        } label: {
                            ZStack {
                                Image(systemName: "plus")
                                    .modifier(FloatingBtnMod())
                            }
                        }
                        .sheet(isPresented: $showSheet) {
                            AddTodoView(todoVm: todoVm, showSheet: $showSheet)
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todoVm: TodoViewModel())
    }
}
