//
//  ContentView.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    var body: some View {
        ZStack {
            if showSplash {
                Image(.logo)
                    .resizableFit()
                    .transition(.scale)
            } else {
                MovieDetailsScreen()
            }
        }
        .task {
            guard showSplash else { return }
            try? await Task.sleep(for: .seconds(0.5))
            withAnimation(.easeOut) {
                showSplash = false
            }
        }
    }
}

#Preview {
    ContentView()
}
