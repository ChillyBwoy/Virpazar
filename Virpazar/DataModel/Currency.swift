//
//  Currency.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//

import UIKit

public struct CurrencyValue {
    let value: Int
    let id: UUID

    init(value: Int) {
        self.id = UUID()
        self.value = value
    }
}

public enum Currency: String, Hashable, CaseIterable {
    case EUR
    case JPY
    case RUB
    case USD
}

// https://ru.wikipedia.org/wiki/Банкнотный_ряд
extension Currency {
    private static var eurValues  = [1, 2, 5, 10, 20, 50, 100, 200, 500].map { CurrencyValue(value: $0) }

    private static var jpyValues = [1, 5, 10, 50, 100, 500, 1000, 2000, 5000, 10000].map { CurrencyValue(value: $0) }
    
    private static var rubValues = [1, 2, 5, 10, 50, 100, 200, 500, 1000, 2000, 5000].map { CurrencyValue(value: $0) }

    private static var usdValues = [1, 2, 5, 10, 20, 50, 100].map { CurrencyValue(value: $0) }

    public var values: [CurrencyValue] {
        get {
            switch self {
            case .EUR:
                return Currency.eurValues

            case .JPY:
                return Currency.jpyValues

            case .RUB:
                return Currency.rubValues

            case .USD:
                return Currency.usdValues
            }
        }
    }
    
    public func symbol() -> String {
        var candidates: [String] = []
        let locales: [String] = NSLocale.availableLocaleIdentifiers

        for localeID in locales {
            guard let symbol = findMatchingSymbol(localeID: localeID, currencyCode: rawValue) else {
                continue
            }

            if symbol.count == 1 {
                return symbol
            }

            candidates.append(symbol)
        }
        
        if candidates.count < 1 {
            return rawValue
        }

        return candidates.sorted(by: { $0.count < $1.count }).first ?? rawValue
    }
    
    private func findMatchingSymbol(localeID: String, currencyCode: String) -> String? {
        let locale = Locale(identifier: localeID as String)
        guard let code = locale.currencyCode else {
            return nil
        }
        if code != currencyCode {
            return nil
        }
        guard let symbol = locale.currencySymbol else {
            return nil
        }
        return symbol
    }
}
