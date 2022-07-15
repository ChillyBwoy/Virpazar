//
//  MainView.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 12.07.2022.
//

import SwiftUI
import Combine

fileprivate class TabBarData: ObservableObject {
    let customActionteminidex: Int
    let objectWillChange = PassthroughSubject<TabBarData, Never>()

    var itemSelected: Int {
        didSet {
            if itemSelected == customActionteminidex {
                itemSelected = oldValue
                isCustomItemSelected = true
            }
            objectWillChange.send(self)
        }
    }

    var isCustomItemSelected: Bool = false

    init(initialIndex: Int = 1, customItemIndex: Int) {
        self.customActionteminidex = customItemIndex
        self.itemSelected = initialIndex
    }
}

struct MainView: View {
    @ObservedObject private var tabData = TabBarData(initialIndex: 1, customItemIndex: 2)

    var body: some View {
        TabView(selection: $tabData.itemSelected) {
            SpendingListView()
                .tabItem {
                    Label("Expenses", systemImage: "calendar")
                }.tag(1)

            Text("Add")
                .tabItem {
                    Label("Add", systemImage: "plus.circle.fill")
                }.tag(2)

            CategoryListView()
                .tabItem {
                    Label("Categories", systemImage: "list.dash")
                }.tag(3)
        }.sheet(
            isPresented: $tabData.isCustomItemSelected,
            onDismiss: {
                
            }) {
                
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        PersistencePreview(dispatch: { provider in
            let stub = SpendingItemStub(provider.context)

            let _ = stub.createMany(count: 50)

            provider.save()
        }) {
            MainView().colorScheme(.light)
        }
    }
}
