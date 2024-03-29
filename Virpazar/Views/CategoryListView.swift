//
//  CategoryListView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 16.07.2022.
//

import SwiftUI

struct CategoryListView: View {
    @FetchRequest(fetchRequest: SpendingCategory.fetchAll())
    private var categories: FetchedResults<SpendingCategory>

    var body: some View {
        NavigationView {
            List(categories, id: \.id) { category in
                Section {
                    NavigationLink(destination: CategoryView(category: category)) {
                        HStack {
                            Circle()
                                .fill(Color(category.color))
                                .frame(width: 24)
                            Text(category.name)
                                .lineLimit(1)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        PersistencePreview(dispatch: { provider in
            let categoriesStub = SpendingCategoryStub(provider.context)
            let itemsStub = SpendingItemStub(provider.context)

            let categories = categoriesStub.createMany()
            
            for category in categories {
                let _ = itemsStub.createMany(category: category, count: 30)
            }

            provider.save()
        }) {
            CategoryListView()
        }
        
    }
}
