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
        
    static func create(in context: NSManagedObjectContext, name: String, date: Date?, endDate: Date?, remindDate: Date?, companyId: String?, companyName: String?) {
        
        let newTask = Task(context: context)
        newTask.createdAt = Date()
        newTask.id = UUID().uuidString
        newTask.name = name
        newTask.date = date
        newTask.endAt = endDate
        newTask.remindAt = remindDate
        newTask.companyId = companyId
        newTask.done = false
        
        if let date = newTask.date {
            if let remindAt = newTask.remindAt {
                // 通知予定
                NotificationManager.instance.scheduleNotification(id: newTask.id!, date: date, time: remindAt, companyName: companyName, taskName: newTask.name!)
                print("notification is scheduled")
            }
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func createDefaultTask(in context: NSManagedObjectContext) {
        
        create(in: context, name: NSLocalizedString("自己分析をする", comment: ""), date: nil, endDate: nil, remindDate: nil, companyId: nil, companyName: nil)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    static func createDefaultCompanyTask(in context: NSManagedObjectContext) {
        
        let today = Date()
        
        create(in: context, name: NSLocalizedString("タスクが完了したら、タップしましょう。", comment: ""), date: Calendar.current.date(byAdding: .hour, value: -5, to: today)!, endDate: Calendar.current.date(byAdding: .hour, value: -4, to: today)!, remindDate: nil, companyId: "default_company", companyName: NSLocalizedString("さんぷる株式会社", comment: ""))
        
        create(in: context, name: NSLocalizedString("1dayインターンシップ", comment: ""), date: Calendar.current.date(byAdding: .hour, value: -24, to: today)!, endDate: Calendar.current.date(byAdding: .hour, value: -23, to: today)!, remindDate: Calendar.current.date(byAdding: .hour, value: -25, to: today)!, companyId: "default_company", companyName: NSLocalizedString("さんぷる株式会社", comment: ""))
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
                           dateIsSet: Bool,
                           date: Date?,
                           endDate: Date?,
                           endDateIsSet: Bool,
                           reminderIsSet: Bool,
                           remindAt: Date?) {
        
        task.name = name
        task.date = date
        task.endAt = endDate
        task.remindAt = remindAt
        task.companyId = companyId
        
        if !dateIsSet {
            task.date = nil
        }
        if !endDateIsSet {
            task.endAt = nil
        }
        if !reminderIsSet {
            task.remindAt = nil
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
