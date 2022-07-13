//
//  SpendingItem+CoreDataClass.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//
//

import Foundation
import CoreData

@objc(SpendingItem)
public class SpendingItem: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var amount: Int32
    @NSManaged public var date: Date
    @NSManaged public var category: SpendingCategory
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

    var type: RecordType {
        set { setRawValue(forKey: "type", value: newValue) }
        get { rawValue(forKey: "type")! }
    }
    
    var currency: Currency {
        set { setRawValue(forKey: "currency", value: newValue) }
        get { rawValue(forKey: "currency")! }
    }
    
    convenience init(context: NSManagedObjectContext,
                     type: RecordType,
                     date: Date,
                     category: SpendingCategory,
                     currency: Currency,
                     latitude: Double,
                     longitude: Double
    ) {
        self.init(context: context)
        self.id = UUID()
        self.amount = 0
        self.date = date
        self.category = category
        self.type = type
        self.currency = currency
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension SpendingItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpendingItem> {
        return NSFetchRequest<SpendingItem>(entityName: "SpendingItem")
    }
    
    @nonobjc class func fetchAll() -> NSFetchRequest<SpendingItem> {
        let request: NSFetchRequest<SpendingItem> = SpendingItem.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]
        return request
    }
}

extension SpendingItem : Identifiable {

}
