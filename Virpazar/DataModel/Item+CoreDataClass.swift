//
//  Item+CoreDataClass.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    @NSManaged public var timestamp: Date?
}

extension Item {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }
}

extension Item : Identifiable {

}
