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

    @NSManaged public var id: String?
    @NSManaged public var companyId: String?
    @NSManaged public var companyName: String?
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var done: Bool

}

extension Task {
        
    static func create(in context: NSManagedObjectContext, name: String, date: Date?, companyId: String?, companyName: String?) {
        let newData = Task(context: context)
        newData.id = UUID().uuidString
        newData.name = name
        newData.date = date
        newData.companyId = companyId
        newData.companyName = companyName
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
//    static func update(currentCompany: Company,
//                imageData: Data,
//                name: String,
//                star: Star,
//                industry: String,
//                location: Location,
//                url: String,
//                memo: String) {
//
//        currentCompany.imageData = imageData
//        currentCompany.name = name
//        currentCompany.star = star.rawValue
//        currentCompany.industry = industry
//        currentCompany.location = location.rawValue
//        currentCompany.url = url
//        currentCompany.memo = memo
//
//    }
    
}

extension Task : Identifiable {

}
