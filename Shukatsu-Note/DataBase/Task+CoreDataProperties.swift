//
//  Task+CoreDataProperties.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/09.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var doneAt: Date?
    @NSManaged public var id: String?
    @NSManaged public var companyId: String?
    @NSManaged public var companyName: String?
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var done: Bool

}

extension Task {
        
    static func create(in context: NSManagedObjectContext, name: String, date: Date?, companyId: String?, companyName: String?) {
        
        let newTask = Task(context: context)
        newTask.createdAt = Date()
        newTask.id = UUID().uuidString
        newTask.name = name
        newTask.date = date
        newTask.companyId = companyId
        newTask.companyName = companyName
        newTask.done = false
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func createDefaultTask(in context: NSManagedObjectContext) {
        
        let newTask = Task(context: context)
        newTask.createdAt = Date()
        newTask.id = UUID().uuidString
        newTask.companyId = nil
        newTask.companyName = nil
        newTask.name = "自己分析をする"
        newTask.date = nil
        newTask.done = false
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    static func createDefaultCompanyTask(in context: NSManagedObjectContext) {
        
        let newTask1 = Task(context: context)
        newTask1.createdAt = Date()
        newTask1.id = UUID().uuidString
        newTask1.companyId = "default_company"
        newTask1.companyName = "さんぷる株式会社"
        newTask1.name = "タスクが完了したら、タップしましょう。"
        newTask1.date = Date()
        newTask1.done = false
        
        let newTask2 = Task(context: context)
        newTask2.createdAt = Date()
        newTask2.id = UUID().uuidString
        newTask2.companyId = "default_company"
        newTask2.companyName = "さんぷる株式会社"
        newTask2.name = "1dayインターンシップ"
        newTask2.date = Date()
        newTask2.done = true
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    static func update(in context: NSManagedObjectContext, task: Task) {
        
        task.done.toggle()
        
        if task.done {
            task.doneAt = Date()
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
}

extension Task : Identifiable {

}
