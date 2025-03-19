//
//  InteractionControlScreen.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import SwiftUI

struct InteractionControlScreen: View {
    @State var interation: UserInteractionControl = .addtoList
    var body: some View {
        HStack(spacing: 20) {
            ForEach(UserInteractionControl.allCases, id: \.id) { interation in
                Button {
                    addInteraction(for: interation)
                } label: {
                    VStack {
                        Image(interation.image)
                            .padding()
                            .background(.secondary, in: .circle)
                        Text(.localizedKey(interation.name))
                            .lineLimit(1)
                    }
                    .roundedText(.footnote, .bold)
                    .foregroundStyle(.gray)
                }

            }
        }
    }
    
    private func addInteraction(for interaction: UserInteractionControl) {
        switch interaction {
        case .addtoList:
            print("Add to list tapped")
        case .trailer:
            print("trailer tapped")
        case .download:
            print("download tapped")
        case .share:
            print("share tapped")
        }
    }
}

#Preview {
    InteractionControlScreen()
}
