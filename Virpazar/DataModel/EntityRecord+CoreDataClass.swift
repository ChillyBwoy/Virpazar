//
//  EntityRecord+CoreDataClass.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//
//

import Foundation
import CoreData

@objc(EntityRecord)
public class EntityRecord: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var amount: Int32
    @NSManaged public var category: Category
    
    var type: RecordType {
        set { setRawValue(forKey: "type", value: newValue) }
        get { rawValue(forKey: "type")! }
    }
    
    var currency: Currency {
        set { setRawValue(forKey: "currency", value: newValue) }
        get { rawValue(forKey: "currency")! }
    }
}

extension EntityRecord {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityRecord> {
        return NSFetchRequest<EntityRecord>(entityName: "EntityRecord")
    }
}

extension EntityRecord : Identifiable {

}
