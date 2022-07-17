//
//  DateSequence.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 17.07.2022.
//
import Foundation

struct DateIterator: IteratorProtocol {
    private var dateComponents: DateComponents
    private let startDate: Date
    private let times: Int
    private var count: Int = 0

    init(_ startDate: Date, times: Int) {
        self.startDate = startDate
        self.dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: startDate)
        self.times = times
    }

    mutating func next() -> Date? {
        guard count < times else {
            return nil
        }
        
        guard let nextDate = Calendar.current.date(from: dateComponents) else {
            return nil
        }
        
        let randMod = Int.random(in: 3..<5)
        if count % randMod == 0 {
            self.dateComponents.day! -= 1
        }
        
        count += 1
        
        return nextDate
    }
}

struct DateSequence: Sequence {
    let startDate: Date
    let times: Int

    func makeIterator() -> DateIterator {
        return DateIterator(startDate, times: times)
    }
}
