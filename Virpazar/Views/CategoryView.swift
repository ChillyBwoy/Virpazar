//
//  CategoryView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//

import SwiftUI

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
    @Environment(\.managedObjectContext) var managedObjectContext

    static var previews: some View {
        let categories = FetchRequest<Category>(
//            entity: Category.entity(),
            sortDescriptors: []
        )

        return Group {
//            Text("Categories: \(categories.wrappedValue[0].name)")
            ForEach(categories.wrappedValue) { category in
                CategoryView(category: category)
            }
        }
        .previewLayout(.fixed(width: 320, height: 50))
    }
}
