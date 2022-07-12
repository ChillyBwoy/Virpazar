//
//  VirpazarApp.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 09.07.2022.
//

import SwiftUI

@main
struct VirpazarApp: App {
    private let persistenceController = PersistenceController()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.context)
        }
    }
}
