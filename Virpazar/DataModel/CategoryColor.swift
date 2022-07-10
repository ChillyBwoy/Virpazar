//
//  CategoryColor.swift
//  Virpazar
//
//  Created by Eugene Cheltsov on 10.07.2022.
//

import UIKit

public enum CategoryColor: String, Codable, CaseIterable {
  case none
  case blue
  case green
  case indigo
  case orange
  case pink
  case purple
  case red
  case teal
  case yellow
  case gray
  case gray2
  case gray3
  case gray4
  case gray5
  case gray6
}

extension CategoryColor {
  public var value: UIColor {
    switch self {
      case .none: return UIColor.black
      case .blue: return UIColor.systemBlue
      case .green: return UIColor.systemGreen
      case .indigo: return UIColor.systemIndigo
      case .orange: return UIColor.systemOrange
      case .pink: return UIColor.systemPink
      case .purple: return UIColor.systemPurple
      case .red: return UIColor.systemRed
      case .teal: return UIColor.systemTeal
      case .yellow: return UIColor.systemYellow
      case .gray: return UIColor.systemGray
      case .gray2: return UIColor.systemGray2
      case .gray3: return UIColor.systemGray3
      case .gray4: return UIColor.systemGray4
      case .gray5: return UIColor.systemGray5
      case .gray6: return UIColor.systemGray6
    }
  }
}
