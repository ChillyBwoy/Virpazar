//
//  SpendingCategory+CoreDataClass.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//
//

import Foundation
import CoreData
import UIKit

@objc(SpendingCategory)
public class SpendingCategory: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var records: Set<SpendingItem>
    @NSManaged public var color: UIColor
    
    convenience init(context: NSManagedObjectContext, name: String) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
//        self.records = Set<EntityRecord>()
        self.color = generateColorFor(name)
    }
    
    private func generateColorFor(_ text: String) -> UIColor {
        var hash = 0
        let colorConstant = 131
        let maxSafeValue = Int.max / colorConstant

        for char in text.unicodeScalars{
            if hash > maxSafeValue {
                hash = hash / colorConstant
            }
            hash = Int(char.value) + ((hash << 5) - hash)
        }

        let finalHash = abs(hash) % (256 * 256 * 256)
        
        return UIColor(
            red: CGFloat((finalHash & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((finalHash & 0xFF00) >> 8) / 255.0,
            blue: CGFloat((finalHash & 0xFF)) / 255.0,
            alpha: 1.0
        )
    }
}

extension SpendingCategory {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpendingCategory> {
        return NSFetchRequest<SpendingCategory>(entityName: "SpendingCategory")
    }

    @nonobjc class func fetchAll() -> NSFetchRequest<SpendingCategory> {
        let request: NSFetchRequest<SpendingCategory> = SpendingCategory.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        return request
    }
}

// MARK: Generated accessors for records
extension SpendingCategory {

    @objc(insertObject:inRecordsAtIndex:)
    @NSManaged public func insertIntoRecords(_ value: SpendingItem, at idx: Int)

    @objc(removeObjectFromRecordsAtIndex:)
    @NSManaged public func removeFromRecords(at idx: Int)

    @objc(insertRecords:atIndexes:)
    @NSManaged public func insertIntoRecords(_ values: [SpendingItem], at indexes: NSIndexSet)

    @objc(removeRecordsAtIndexes:)
    @NSManaged public func removeFromRecords(at indexes: NSIndexSet)

    @objc(replaceObjectInRecordsAtIndex:withObject:)
    @NSManaged public func replaceRecords(at idx: Int, with value: SpendingItem)

    @objc(replaceRecordsAtIndexes:withRecords:)
    @NSManaged public func replaceRecords(at indexes: NSIndexSet, with values: [SpendingItem])

    @objc(addRecordsObject:)
    @NSManaged public func addToRecords(_ value: SpendingItem)

    @objc(removeRecordsObject:)
    @NSManaged public func removeFromRecords(_ value: SpendingItem)

    @objc(addRecords:)
    @NSManaged public func addToRecords(_ values: NSOrderedSet)

    @objc(removeRecords:)
    @NSManaged public func removeFromRecords(_ values: NSOrderedSet)

}
