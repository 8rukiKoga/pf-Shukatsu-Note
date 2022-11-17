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
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var endAt: Date?
    @NSManaged public var remindAt: Date?
    @NSManaged public var done: Bool

}

extension Task {
        
    static func create(in context: NSManagedObjectContext, name: String, date: Date?, endDate: Date?, remindDate: Date?, company: Company?) {
        
        let newTask = Task(context: context)
        newTask.createdAt = Date()
        newTask.id = UUID().uuidString
        newTask.name = name
        newTask.date = date
        newTask.endAt = endDate
        newTask.remindAt = remindDate
        newTask.companyId = company?.id
        newTask.done = false
        
        if newTask.date != nil {
            if newTask.remindAt != nil {
                // 通知予定
                NotificationManager.instance.scheduleNotification(id: newTask.id!, date: date!, time: remindDate!, companyName: company?.name, taskName: newTask.name!)
            }
        }
        
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
        newTask.name = NSLocalizedString("自己分析をする", comment: "")
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
        newTask1.name = NSLocalizedString("タスクが完了したら、タップしましょう。", comment: "")
        newTask1.date = Date()
        newTask1.done = false
        
        let newTask2 = Task(context: context)
        newTask2.createdAt = Date()
        newTask2.id = UUID().uuidString
        newTask2.companyId = "default_company"
        newTask2.name = NSLocalizedString("1dayインターンシップ", comment: "")
        newTask2.date = Date()
        newTask2.done = true
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    static func updateStatus(in context: NSManagedObjectContext, task: Task) {
        
        task.done.toggle()
        
        if task.done {
            task.doneAt = Date()
        } else {
            task.doneAt = nil
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func updateTask(in context: NSManagedObjectContext,
                           task: Task,
                           companyId: String?,
                           name: String?,
                           date: Date?,
                           endDate: Date?,
                           remindAt: Date?) {
        
        task.name = name
        task.date = date
        task.endAt = endDate
        task.remindAt = remindAt
        task.companyId = companyId
        
        
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
}

extension Task : Identifiable {

}
