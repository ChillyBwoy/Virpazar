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
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                NavigationLink(destination: Text("Second View")) {
                    Text("Goto")
                }

                ForEach(entities, id: \.id) { entity in
                    Text("\(entity.id)")
                }
            }
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
        SpendingListView()
    }
}
