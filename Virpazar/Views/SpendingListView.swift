//
//  SpendingListView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 13.07.2022.
//

import SwiftUI

struct SpendingListView: View {
    @Environment(\.managedObjectContext) private var ctx

    @FetchRequest(fetchRequest: SpendingItem.fetchAll())
    private var entities: FetchedResults<SpendingItem>

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }

    var body: some View {
        NavigationView {
             List(SpendingItem.groupByDate(entities), id: \.0) { (date, items) in
                 ExpensesOnTheDate(items: items, date: date)
             }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct SpendingListView_Previews: PreviewProvider {
    static var previews: some View {
        PersistencePreview(dispatch: { provider in
            let stub = SpendingItemStub(provider.context)

            let _ = stub.createMany(count: 50)

            provider.save()
        }) {
            SpendingListView()
        }
    }
}
