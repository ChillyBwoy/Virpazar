//
//  VirpazarApp.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 09.07.2022.
//

import SwiftUI

@main
struct VirpazarApp: App {
    let persistenceController = PersistenceController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.context)
        }
    }
}
