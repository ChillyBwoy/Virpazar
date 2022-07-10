//
//  DataProvider.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//

import CoreData

protocol DataProvider {
    var containerName: String { get }
    var context: NSManagedObjectContext { get }

    func save() -> Void
}

extension DataProvider {
    func save() {
      if context.hasChanges {
        do {
          try context.save()
        } catch {
          // Replace this implementation with code to handle the error appropriately.
          // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }
}
