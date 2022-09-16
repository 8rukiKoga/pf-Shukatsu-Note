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
        
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        
        return fetchRequest
        
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var id: String?
    @NSManaged public var companyId: String?
    @NSManaged public var text: String?

}

extension Note {
        
    static func create(in context: NSManagedObjectContext, companyId: String?) {
        
        let newNote = Note(context: context)
        newNote.createdAt = Date()
        newNote.id = UUID().uuidString
        newNote.companyId = companyId
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func createDefaultNote(in context: NSManagedObjectContext) {
        
        let newNote1 = Note(context: context)
        newNote1.createdAt = Date()
        newNote1.id = UUID().uuidString
        newNote1.companyId = nil
        newNote1.text = "自分の就活の軸"
        
        let newNote2 = Note(context: context)
        newNote2.createdAt = Date()
        newNote2.id = UUID().uuidString
        newNote2.companyId = nil
        newNote2.text = "ここには就活全体のノートを保存できます"
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    static func createDefaultCompanyNote(in context: NSManagedObjectContext) {
        
        let newNote1 = Note(context: context)
        newNote1.createdAt = Date()
        newNote1.id = UUID().uuidString
        newNote1.companyId = "default_company"
        newNote1.text = "インターンで学んだこと"
        
        let newNote2 = Note(context: context)
        newNote2.createdAt = Date()
        newNote2.id = UUID().uuidString
        newNote2.companyId = "default_company"
        newNote2.text = "ここには企業に関するノートを保存できます。"
        
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
