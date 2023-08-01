//
//  Book+CoreDataProperties.swift
//  PDF_CoreData
//
//  Created by KO NISHIYAMA on 2023/07/29.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var title: String?
    @NSManaged public var coverImageURL: String?
    @NSManaged public var url: String?
    @NSManaged public var createdAt: Date?

}

extension Book : Identifiable {
    public var stringCreatedAt: String { dateFomatter(date: createdAt ?? Date()) }
        
        func dateFomatter(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

            return dateFormatter.string(from: date)
        }

}
