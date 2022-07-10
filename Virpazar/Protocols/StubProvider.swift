//
//  StubProvider.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//

import CoreData

protocol StubProvider {
    associatedtype Entity
    
    func createMany(context: NSManagedObjectContext) -> [Entity]
}
