//
//  ExpensesOnTheDate.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 17.07.2022.
//

import SwiftUI

struct ExpensesOnTheDate: View {
    let items: [SpendingItem]
    let date: Date
    let showCategory: Bool
    
    init(items: [SpendingItem], date: Date, showCategory: Bool = true) {
        self.items = items
        self.date = date
        self.showCategory = showCategory
    }

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()

            Text(date, style: .date)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
            VStack(alignment: .trailing) {
                ForEach(items, id: \.id) { item in
                    HStack {
                        if showCategory {
                            Text(item.category?.name ?? "No category")
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color(item.category?.color ?? .gray))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                                .lineLimit(1)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: item.currency.rawValue))
                    }.font(.body)
                }

                Spacer()

                ForEach(SpendingItem.totalByCurrency(items), id: \.0) { (currency, sum) in
                    Text(sum, format: .currency(code: currency.rawValue))
                        .font(.title2)
                }
            }
            Spacer()
        }
    }
}

struct ExpensesOnTheDate_Previews: PreviewProvider {
    static var previews: some View {
        PersistencePreview { provider in
            let stub = SpendingItemStub(provider.context)
            let date = Date()
            let items = stub.createMany(date: date, count: 6)
            
            ExpensesOnTheDate(items: items, date: date, showCategory: true)
                .padding()
                .previewLayout(.fixed(width: 320, height: 250))
        }
    }
}
