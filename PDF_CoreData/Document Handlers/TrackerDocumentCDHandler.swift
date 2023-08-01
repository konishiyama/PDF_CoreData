//
//  TrackerDocumentCDHandler.swift
//  SwiftUIDocumentsDemo (iOS)
//
//  Created by Mahesh sai on 07/09/21.
//

import Foundation

import CoreData

struct TrackerDocumentCoreDataHandler {
    var context = PersistenceController.shared.container.viewContext
    func addTrackerDocument(title: String, location: String, url: String, size: String, to project: Project) -> Book? {
        if(!title.isEmpty) {
            let docToBeAdded = Book(context: context)
            docToBeAdded.title = title
            docToBeAdded.url = url
            docToBeAdded.createdAt = Date()
//            project.addToDocuments(docToBeAdded)
            save()
            return docToBeAdded
        }
        return nil
    }
    
    func listOfTrackerDocuments() -> [Book] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TrackerDocument")
        var items = [Book]()
        do {
            items = try context.fetch(fetchRequest) as! [Book]
        }
        catch {
            print(error)
        }
        return items
    }
//    func listOfTrackerDocuments(in project: Project) -> [Book] {
//        let items: [Book] = project.documents?.allObjects as? [Book] ?? []
//        return items
//    }
   
    
//    func reloadBug(name: String) -> Bug {
//        let fr: NSFetchRequest = Bug.fetchRequest()
//        let predicate: NSPredicate = NSPredicate(format: "title == %@", name)
//        fr.predicate = predicate
//        var items = [Bug]()
//        do {
//            items = try context.fetch(fr)
//        } catch {
//
//        }
//        return items[0]
//    }
    func deleteTrackerDocument(doc: Book) {
        context.delete(doc)
        save()
    }
    func save() {
        if context.hasChanges {
            
            do {
                try context.save()
            }
            catch {
                print(error)
            }
        }
    }
}
