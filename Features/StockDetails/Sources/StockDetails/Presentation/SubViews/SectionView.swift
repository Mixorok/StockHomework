//
//  File.swift
//  StockDetails
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

import SwiftUI

internal struct SectionView<Content: View>: View {

    private let content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack(spacing: 8) {
            content
        }
        Divider()
    }
}
