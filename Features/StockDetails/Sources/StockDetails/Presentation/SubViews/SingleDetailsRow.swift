//
//  File.swift
//  StockDetails
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

import SwiftUI

internal struct SingleDetailsRow: View {

    private let title: String
    private let description: String

    init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .font(.footnote)
                .foregroundStyle(Color.gray)

            Spacer()

            Text(description)
                .font(.body)
        }
    }
}
