//
//  NSManagedObject+rawValue.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//

import CoreData
import Foundation

extension NSManagedObject {
  func setRawValue<ValueType: RawRepresentable>(forKey key: String, value: ValueType) {
    willChangeValue(forKey: key)
    setPrimitiveValue(value.rawValue as AnyObject, forKey: key)
    didChangeValue(forKey: key)
  }

  func rawValue<ValueType: RawRepresentable>(forKey key: String) -> ValueType? {
    willAccessValue(forKey: key)

    let result = primitiveValue(forKey: key) as! ValueType.RawValue
    didAccessValue(forKey: key)

    return ValueType(rawValue: result)
  }
}

