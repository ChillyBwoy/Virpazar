//
//  SpendingItem+CoreDataProperties.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 16.07.2022.
//
//

import Foundation
import CoreData


extension SpendingItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpendingItem> {
        return NSFetchRequest<SpendingItem>(entityName: "SpendingItem")
    }

    @NSManaged public var amount: Int32
    @NSManaged public var currency: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var type: String?
    @NSManaged public var category: SpendingCategory?

}

extension SpendingItem : Identifiable {

}
