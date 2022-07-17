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
        Text(category.name)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        
        PersistencePreview { provider in
            let itemsStub = SpendingItemStub(provider.context)
            
            let category = SpendingCategory(provider.context, name: "Some random category")
            let _ = itemsStub.createMany(category: category, count: 30)
            let _ = provider.save()

            CategoryView(category: category)
        }
    }
}
