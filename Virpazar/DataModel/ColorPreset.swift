//
//  ColorPreset.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 17.07.2022.
//

import UIKit

public enum ColorPreset: Codable, CaseIterable {
    case generated(String)
    case none, blue, green, indigo, orange, pink, purple, red, teal, yellow, gray, gray2, gray3, gray4, gray5, gray6

    
    static public var allCases: [ColorPreset] {
        return [
            .generated("unknown"),
            .none, .blue, .green, .indigo, .orange, .pink, .purple, .red, .teal, .yellow, .gray, .gray2, .gray3, .gray4, .gray5, .gray6
        ]
    }
}

extension ColorPreset {
    public var value: UIColor {
        switch self {
        case .generated(let str):
            return generateColorFor(str)

        case .none:
            return UIColor.black

        case .blue:
            return UIColor.systemBlue

        case .green:
            return UIColor.systemGreen

        case .indigo:
            return UIColor.systemIndigo

        case .orange:
            return UIColor.systemOrange

        case .pink:
            return UIColor.systemPink

        case .purple:
            return UIColor.systemPurple

        case .red:
            return UIColor.systemRed

        case .teal:
            return UIColor.systemTeal

        case .yellow:
            return UIColor.systemYellow

        case .gray:
            return UIColor.systemGray

        case .gray2:
            return UIColor.systemGray2

        case .gray3:
            return UIColor.systemGray3

        case .gray4:
            return UIColor.systemGray4
        
        case .gray5:
            return UIColor.systemGray5

        case .gray6:
            return UIColor.systemGray6
        }
    }

    private func generateColorFor(_ text: String) -> UIColor {
        var hash = 0
        let colorConstant = 131
        let maxSafeValue = Int.max / colorConstant

        for char in text.unicodeScalars{
            if hash > maxSafeValue {
                hash = hash / colorConstant
            }
            hash = Int(char.value) + ((hash << 5) - hash)
        }

        let finalHash = abs(hash) % (256 * 256 * 256)
        
        return UIColor(
            red: CGFloat((finalHash & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((finalHash & 0xFF00) >> 8) / 255.0,
            blue: CGFloat((finalHash & 0xFF)) / 255.0,
            alpha: 1.0
        )
    }
}
