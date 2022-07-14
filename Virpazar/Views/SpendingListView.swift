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
                
                Spacer()
                VStack(alignment: .trailing) {
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
//            NavigationLink(destination: Text("Second View")) {
//                Text("Goto")
//            }

             List(SpendingItem.groupByDate(entities), id: \.0) { (date, items) in
                 SpendingItemsGroupedByDateView(items: items, date: date)
             }
//            .listStyle(.grouped)

            .navigationTitle("Title")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                       Spacer()
               }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                      print("Add")
                    }) {
                      Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct SpendingListView_Previews: PreviewProvider {
    static var previews: some View {
        PersistencePreview(dispatch: { provider in
            let lat = 35.68173905166872
            let lan = 139.76542760754913
            
            let categories = [
                SpendingCategory(context: provider.context, name: "Grocery", color: .green),
                SpendingCategory(context: provider.context, name: "Transport", color: .blue),
                SpendingCategory(context: provider.context, name: "Cafe", color: .red),
                SpendingCategory(context: provider.context, name: "Rent", color: .teal)
            ]

            let now = Date()
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: now)

            for idx in 0...50 {
                let _ = SpendingItem(
                    context: provider.context,
                    type: .spend,
                    date: Calendar.current.date(from: dateComponents)!,
                    category: categories.randomElement()!,
                    currency: .JPY,
                    latitude: lat,
                    longitude: lan,
                    amount: Int.random(in: 100..<1000)
                )
                
                let randMod = Int.random(in: 3..<5)
                if idx % randMod == 0 {
                    dateComponents.day! -= 1
                }
            }

            provider.save()
        }) {
            SpendingListView()
        }
    }
}
