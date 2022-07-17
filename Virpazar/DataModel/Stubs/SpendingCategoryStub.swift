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
            SpendingCategory(ctx, name: "Grocery"),
            SpendingCategory(ctx, name: "Transport"),
            SpendingCategory(ctx, name: "Cafe"),
            SpendingCategory(ctx, name: "Rent"),
            SpendingCategory(ctx, name: "A brand new category with a pretty long name")
        ]
    }
}
