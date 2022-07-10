//
//  Category.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//

import CoreData

class CategoryStub: StubProvider {
    func createMany(context: NSManagedObjectContext) -> [Category] {
        return [
            Category(context: context, name: "Grocery", color: .teal),
            Category(context: context, name: "Restaurant", color: .red),
            Category(context: context, name: "Public Transport", color: .blue)
        ]
    }
}
