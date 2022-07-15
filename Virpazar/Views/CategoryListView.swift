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
                    NavigationLink(destination: Text("Second View")) {
                        HStack {
                            Circle()
                                .fill(Color(category.color.value))
                                .frame(width: 20)
                            Text(category.name)
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
            let stub = SpendingCategoryStub(provider.context)
            let _ = stub.createMany()

            provider.save()
        }) {
            CategoryListView()
        }
        
    }
}
