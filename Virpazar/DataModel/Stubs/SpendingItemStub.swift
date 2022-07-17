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
    
    private func randCoords() -> (Double, Double) {
        (35.68173905166872, 139.76542760754913)
    }
    
    func createMany(category: SpendingCategory, count: Int) -> [SpendingItem] {
        let (lan, lat) = randCoords()
        
        var data = [SpendingItem]()
        
        for date in DateSequence(startDate: Date(), times: count) {
            data.append(
                SpendingItem(
                    ctx,
                    type: .spend,
                    date: date,
                    category: category,
                    currency: .JPY,
                    latitude: lat,
                    longitude: lan,
                    amount: Int.random(in: 100..<1500)
                )
            )
        }

        return data
    }

    func createMany(count: Int) -> [SpendingItem] {
        let spendingCategoryStub = SpendingCategoryStub(ctx)
        let categories = spendingCategoryStub.createMany()
        let (lan, lat) = randCoords()

        var data = [SpendingItem]()

        for date in DateSequence(startDate: Date(), times: count) {
            print(date)

            data.append(
                SpendingItem(
                    ctx,
                    type: .spend,
                    date: date,
                    category: categories.randomElement()!,
                    currency: .JPY,
                    latitude: lat,
                    longitude: lan,
                    amount: Int.random(in: 100..<1500)
                )
            )
        }

        return data
    }
}
