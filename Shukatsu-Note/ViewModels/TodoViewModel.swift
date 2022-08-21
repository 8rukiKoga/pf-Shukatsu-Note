//
//  TodoViewModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/14.
//

import Foundation

class TodoViewModel: ObservableObject {
    @Published var todoList: [TodoModel] = [] {
        didSet {
            saveTodo()
        }
    }
    
    init() {
        getTodo()
    }
    
    let noteListKey = "noteListKey"
    
    // データを読み込む
    func getTodo() {
        guard
            let data = UserDefaults.standard.data(forKey: noteListKey),
            let savedNotes = try? JSONDecoder().decode([TodoModel].self, from: data)
        else { return }
        
        todoList = savedNotes
    }
    
    func deleteTodo(indexSet: IndexSet) {
        todoList.remove(atOffsets: indexSet)
    }
    
    func moveTodo(from: IndexSet, to: Int) {
        todoList.move(fromOffsets: from, toOffset: to)
    }
    
    func addTodo(name: String, date: Date, dateIsSet: Bool, company: CompanyModel?) {
        let newTask = TodoModel(name: name, date: date, dateIsSet: dateIsSet, company: company, done: false)
        todoList.append(newTask)
    }
    
    func saveTodo() {
        if let encodedData = try? JSONEncoder().encode(todoList) {
            UserDefaults.standard.set(encodedData, forKey: noteListKey)
        }
    }
}

var sampleTodo = [
    TodoModel(name: "task1", done: false),
    TodoModel(name: "task2", done: false),
    TodoModel(name: "task3", done: true)
]
