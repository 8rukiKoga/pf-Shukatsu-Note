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

    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var id: String?
    @NSManaged public var companyId: String?
    @NSManaged public var text: String?

}

extension Note {
        
    static func create(in context: NSManagedObjectContext) {
        
        let newNote = Note(context: context)
        newNote.id = UUID().uuidString
        newNote.createdAt = Date()
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func update(in context: NSManagedObjectContext, currentNote: Note, text: String) {
        
        currentNote.updatedAt = Date()
        currentNote.text = text
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
}

extension Note : Identifiable {

}
