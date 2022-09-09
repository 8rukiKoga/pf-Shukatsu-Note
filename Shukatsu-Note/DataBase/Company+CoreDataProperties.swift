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
        let newData = Company(context: context)
        newData.id = UUID().uuidString
        newData.name = name
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func createDefaultCompany(in context: NSManagedObjectContext) -> Company {
        let defCompany = Company(context: context)
        defCompany.id = UUID().uuidString
        defCompany.name = "未選択"
        defCompany.id = "misettei_no_id"
        return defCompany
    }
    
    static func deleteAll(in context: NSManagedObjectContext) {
        
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

extension Company : Identifiable {
    
}
