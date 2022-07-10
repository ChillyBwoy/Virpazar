//
//  CategoryView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//

import SwiftUI
import CoreData

struct CategoryView: View {
    var category: Category

    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                .fill(Color(category.color.value))
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
                CategoryView(category: Category(context: provider.context, name: "Grocery", color: .teal))
                CategoryView(category: Category(context: provider.context, name: "Restaurant", color: .red))
                CategoryView(category: Category(context: provider.context, name: "Public Transport", color: .blue))
            }
            .previewLayout(.fixed(width: 320, height: 50))
        }
    }
}
