//
//  CurrencyFormatter.swift
//  CatalogProductOrder_Interview_Project
//
//  Created by Sean Murphy on 11/11/24.
//

import Foundation

class CurrencyFormatter: NumberFormatter {
  static let shared = CurrencyFormatter()

  override private init() {
    super.init()
    numberStyle = .currency
    negativeFormat = "-¤#,##0.00"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  internal func string(from double: Double) -> String {
    if double.isNaN {
      return ""
    }
    return string(from: NSNumber(value: double)) ?? ""
  }
}
