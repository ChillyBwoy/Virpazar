//
//  SpendingItem+CoreDataClass.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//
//

import SwiftUI
import CoreData

@objc(SpendingItem)
public class SpendingItem: NSManagedObject, Identifiable {
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
    
    convenience init(context: NSManagedObjectContext,
                     type: RecordType,
                     date: Date,
                     category: SpendingCategory,
                     currency: Currency,
                     latitude: Double,
                     longitude: Double,
                     amount: Int
    ) {
        self.init(context: context, type: type, date: date, category: category, currency: currency, latitude: latitude, longitude: longitude)
        self.amount = Int32(amount)
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

extension SpendingItem {
    static func groupByDate(_ result: FetchedResults<SpendingItem>) -> [(Date, [SpendingItem])] {
        let groups = Dictionary(grouping: result, by: { item in item.date })

        let sortedKeys: [Date] = groups.keys.sorted { (a, b) -> Bool in
            if let itemA = groups[a]?[0], let itemB = groups[b]?[0] {
                return itemA.date.compare(itemB.date) == .orderedDescending
            }
            return false
        }

        return sortedKeys.map { ($0, groups[$0] ?? []) }
    }
    
    static func groupByCategory(_ result: [SpendingItem]) -> [(SpendingCategory, [SpendingItem])] {
        let groups = Dictionary(grouping: result, by: { item in item.category })
        
        return groups.keys.map { ($0, groups[$0] ?? []) }
    }
    
    static func totalByCurrency(_ result: [SpendingItem]) -> [(Currency, Int)] {
        let groups = Dictionary(grouping: result, by: { item in item.currency })

        return groups.keys.map { ($0, (groups[$0] ?? []).reduce(0) { $0 + Int($1.amount) }) }
    }
}
