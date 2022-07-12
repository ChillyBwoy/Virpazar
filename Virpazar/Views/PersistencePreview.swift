//
//  Preview.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//

import SwiftUI
import CoreData

struct PersistencePreview<Content: View>: View {
    var content: Content
    private var persistanceController: DataProvider
    
    init(dispatch callback: (_ provider: DataProvider) -> Void, @ViewBuilder content: (_ provider: DataProvider) -> Content) {
        persistanceController = PersistenceControllerMemory()
        
        callback(persistanceController)
        
        self.content = content(persistanceController)
    }
    
    init(dispatch callback: (_ provider: DataProvider) -> Void, @ViewBuilder content: () -> Content) {
        persistanceController = PersistenceControllerMemory()
        
        callback(persistanceController)
        
        self.content = content()
    }
    
    init(@ViewBuilder content: (_ provider: DataProvider) -> Content) {
        persistanceController = PersistenceControllerMemory()

        self.content = content(persistanceController)
    }
    
    init(@ViewBuilder content: () -> Content) {
        persistanceController = PersistenceControllerMemory()

        self.content = content()
    }
    
    var body: some View {
        content.environment(\.managedObjectContext, persistanceController.context)
    }
}
