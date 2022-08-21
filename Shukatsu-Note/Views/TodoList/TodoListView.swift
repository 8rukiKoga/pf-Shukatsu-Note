//
//  TodoListView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct TodoListView: View {
    
    @ObservedObject var todoVm: TodoViewModel
    @ObservedObject var companyVm: CompanyViewModel
    @State var showSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if todoVm.todoList.isEmpty {
                    VStack {
                        Spacer()
                        Text("No Items")
                            .font(.caption)
                            .padding(.bottom)
                        // No Itemsテキストを上に移動させるために下にアイテムを置く
                        Text("_")
                            .opacity(0)
                        Spacer()
                    }
                }
                else {
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
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todoVm: TodoViewModel(), companyVm: CompanyViewModel())
    }
}
