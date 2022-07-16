//
//  SpendingListView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 13.07.2022.
//

import SwiftUI

fileprivate struct SpendingItemsGroupedByDateView: View {
    let items: [SpendingItem]
    let date: Date
    
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                Spacer()

                Text(date, style: .date)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    ForEach(items, id: \.id) { item in
                        HStack {
                            Text(item.category?.name ?? "No category")
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(Color(item.category?.color ?? .gray))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                                .lineLimit(1)
                            Spacer()
                            Text(item.amount, format: .currency(code: item.currency.rawValue))
                        }.font(.subheadline)
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
}

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
                 SpendingItemsGroupedByDateView(items: items, date: date)
             }

            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .bottomBar) {
//                       Spacer()
//               }
//                ToolbarItem(placement: .bottomBar) {
//                    Button(action: {
//                      print("Add")
//                    }) {
//                      Image(systemName: "plus")
//                    }
//                }
//            }
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
