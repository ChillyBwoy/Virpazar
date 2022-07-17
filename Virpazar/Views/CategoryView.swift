//
//  CategoryView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 17.07.2022.
//

import SwiftUI

struct CategoryView: View {
    let category: SpendingCategory

    var body: some View {
        List(SpendingItem.groupByDate(category.records), id: \.0) { (date, items) in
            ExpensesOnTheDate(items: items, date: date, showCategory: false)
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem() {
                EditButton()
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        
        PersistencePreview { provider in
            let itemsStub = SpendingItemStub(provider.context)
            
            let category = SpendingCategory(provider.context, name: "Random category")
            let _ = itemsStub.createMany(category: category, count: 30)
            let _ = provider.save()

            CategoryView(category: category)
        }
    }
}
