//
//  Note+CoreDataProperties.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/09.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: String?
    @NSManaged public var companyId: String?
    @NSManaged public var text: String?

}

extension Note {
        
    static func create(in context: NSManagedObjectContext) {
        let newData = Note(context: context)
        newData.id = UUID().uuidString
        
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

extension Note : Identifiable {

}
