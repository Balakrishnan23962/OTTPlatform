//
//  LazyStackView.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import SwiftUI

struct LazyStackView<Item: Identifiable, Content: View>: View {
    let items: [Item]
    let isHorizontal: Bool
    let spacing: CGFloat
    let neededFrame: CGFloat
    let content: (Item) -> Content
    var body: some View {
        ScrollView(isHorizontal ? .horizontal : .vertical) {
            getStacks(isHorizontal: isHorizontal, spacing: spacing) {
                ForEach(items) { item in
                    content(item)
                }
            }
        }
    }
    
    private func getStacks(
        isHorizontal: Bool,
        spacing: CGFloat,
        @ViewBuilder content: () -> some View
    ) -> some View {
        Group {
            if isHorizontal {
                LazyHStack(spacing: spacing) {
                    content()
                        .containerRelativeFrame(.horizontal) { width, _ in
                            return width / neededFrame
                        }
                }
            } else {
                LazyVStack(spacing: spacing) {
                    content()
                        .containerRelativeFrame(.vertical) { height, _ in
                            return height / neededFrame
                        }
                }
            }
        }
    }
}
