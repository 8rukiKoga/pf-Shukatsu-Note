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
        let newTask = Task(context: context)
        newTask.createdAt = Date()
        newTask.id = UUID().uuidString
        newTask.companyId = "default_company"
        newTask.companyName = "さんぷる株式会社"
        newTask.name = "説明会"
        newTask.date = Date()
        newTask.done = true
        
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
