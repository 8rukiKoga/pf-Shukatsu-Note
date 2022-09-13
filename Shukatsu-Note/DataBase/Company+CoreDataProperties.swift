//
//  Company+CoreDataProperties.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/08.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }
    
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var id: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var star: Int16
    @NSManaged public var category: String?
    @NSManaged public var location: String?
    @NSManaged public var url: String?
    @NSManaged public var memo: String?

}

extension Company {
        
    static func create(in context: NSManagedObjectContext, name: String) {
        
        let newCompany = Company(context: context)
        newCompany.createdAt = Date()
        newCompany.updatedAt = Date()
        newCompany.id = UUID().uuidString
        newCompany.name = name
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func updateInfo(in context: NSManagedObjectContext,
                currentCompany: Company,
                image: Data,
                name: String,
                star: Int,
                category: String,
                location: String,
                url: String) {
        
        currentCompany.updatedAt = Date()
        currentCompany.image = image
        currentCompany.name = name
        currentCompany.star = Int16(star)
        currentCompany.category = category
        currentCompany.location = location
        currentCompany.url = url
        
        do {
            try context.save()
        } catch {
            print(error)
        }

    }
    
    static func updateMemo(in context: NSManagedObjectContext, currentCompany: Company, memo: String) {
        
        currentCompany.memo = memo
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
}

extension Company : Identifiable {
    
}
