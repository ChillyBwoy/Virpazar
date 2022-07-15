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
            SpendingCategory(context: ctx, name: "Grocery", color: .green),
            SpendingCategory(context: ctx, name: "Transport", color: .blue),
            SpendingCategory(context: ctx, name: "Cafe", color: .red),
            SpendingCategory(context: ctx, name: "Rent", color: .teal)
        ]
    }
}
