//
//  Category+CoreDataClass.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var records: Set<EntityRecord>

    var color: CategoryColor {
      set { setRawValue(forKey: "color", value: newValue) }
      get { rawValue(forKey: "color")! }
    }
    
    convenience init(context: NSManagedObjectContext, name: String, color: CategoryColor) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
//        self.records = Set<EntityRecord>()
        self.color = color
    }
}

extension Category {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }
    
    @nonobjc class func fetchAll() -> NSFetchRequest<Category> {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        return request
    }
}

// MARK: Generated accessors for records
extension Category {

    @objc(insertObject:inRecordsAtIndex:)
    @NSManaged public func insertIntoRecords(_ value: EntityRecord, at idx: Int)

    @objc(removeObjectFromRecordsAtIndex:)
    @NSManaged public func removeFromRecords(at idx: Int)

    @objc(insertRecords:atIndexes:)
    @NSManaged public func insertIntoRecords(_ values: [EntityRecord], at indexes: NSIndexSet)

    @objc(removeRecordsAtIndexes:)
    @NSManaged public func removeFromRecords(at indexes: NSIndexSet)

    @objc(replaceObjectInRecordsAtIndex:withObject:)
    @NSManaged public func replaceRecords(at idx: Int, with value: EntityRecord)

    @objc(replaceRecordsAtIndexes:withRecords:)
    @NSManaged public func replaceRecords(at indexes: NSIndexSet, with values: [EntityRecord])

    @objc(addRecordsObject:)
    @NSManaged public func addToRecords(_ value: EntityRecord)

    @objc(removeRecordsObject:)
    @NSManaged public func removeFromRecords(_ value: EntityRecord)

    @objc(addRecords:)
    @NSManaged public func addToRecords(_ values: NSOrderedSet)

    @objc(removeRecords:)
    @NSManaged public func removeFromRecords(_ values: NSOrderedSet)

}
