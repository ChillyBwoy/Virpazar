//
//  CategoryView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//

import SwiftUI
import CoreData

struct CategoryView: View {
    var category: SpendingCategory

    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                .fill(Color(category.color))
            HStack(alignment: .center, spacing: 2) {
                Text(category.name)
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
        }.fixedSize(horizontal: true, vertical: true)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        PersistencePreview{ provider in
            Group {
                CategoryView(category: SpendingCategory(context: provider.context, name: "Grocery"))
                CategoryView(category: SpendingCategory(context: provider.context, name: "Restaurant"))
                CategoryView(category: SpendingCategory(context: provider.context, name: "Public Transport"))
            }
            .previewLayout(.fixed(width: 320, height: 50))
        }
    }
}
