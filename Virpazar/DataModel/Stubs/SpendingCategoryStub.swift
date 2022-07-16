//
//  SpendingCategory+Stub.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 15.07.2022.
//

import CoreData

class SpendingCategoryStub: StubProvider {
    typealias Entity = SpendingCategory

    private let ctx: NSManagedObjectContext

    required init(_ ctx: NSManagedObjectContext) {
        self.ctx = ctx
    }

    func createMany() -> [SpendingCategory] {
        return [
            SpendingCategory(context: ctx, name: "Grocery"),
            SpendingCategory(context: ctx, name: "Transport"),
            SpendingCategory(context: ctx, name: "Cafe"),
            SpendingCategory(context: ctx, name: "Rent"),
            SpendingCategory(context: ctx, name: "A brand new category with a pretty long name")
        ]
    }
}
