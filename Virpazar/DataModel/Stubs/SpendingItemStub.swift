//
//  SpendingItemStub.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 15.07.2022.
//

import CoreData



class SpendingItemStub: StubProvider {
    typealias Entity = SpendingItem

    private let ctx: NSManagedObjectContext

    required init(_ ctx: NSManagedObjectContext) {
        self.ctx = ctx
    }

    func createMany(count: Int) -> [SpendingItem] {
        let spendingCategoryStub = SpendingCategoryStub(ctx)

        let categories = spendingCategoryStub.createMany()
        
        
        let lat = 35.68173905166872
        let lan = 139.76542760754913
        
        let now = Date()
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: now)
        
        var data = [SpendingItem]()

        for idx in 0..<count {
            data.append(
                SpendingItem(
                    context: ctx,
                    type: .spend,
                    date: Calendar.current.date(from: dateComponents)!,
                    category: categories.randomElement()!,
                    currency: .JPY,
                    latitude: lat,
                    longitude: lan,
                    amount: Int.random(in: 100..<1000)
                )
            )

            let randMod = Int.random(in: 3..<5)
            if idx % randMod == 0 {
                dateComponents.day! -= 1
            }
        }

        return data
    }
}
