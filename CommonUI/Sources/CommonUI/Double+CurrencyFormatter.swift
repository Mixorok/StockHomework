//
//  Double+CurrencyFormatter.swift
//  CommonUI
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

public extension Double {

    var asCurrency: String {
        String(format: "$%.2f", self)
    }
}
