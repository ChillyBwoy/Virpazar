//
//  CategorySelectView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 30.07.2022.
//

import SwiftUI

struct CategorySelectView: View {
    @FetchRequest(fetchRequest: SpendingCategory.fetchAll())
    private var categories: FetchedResults<SpendingCategory>

    var body: some View {
        List(categories, id: \.id) { category in
            NavigationLink(destination: CategoryView(category: category)) {
                HStack {
                    Circle()
                        .fill(Color(category.color))
                        .frame(width: 24)
                    Text(category.name)
                        .lineLimit(1)
                    Spacer()
                }
            }.padding()
        }
    }
}

struct CategorySelectView_Previews: PreviewProvider {
    static var previews: some View {
        PersistencePreview(dispatch: { provider in
            let stub = SpendingCategoryStub(provider.context)
            let _ = stub.createMany()

            provider.save()
        }) {
            CategorySelectView()
        }
    }
}
