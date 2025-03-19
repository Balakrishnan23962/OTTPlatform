//
//  CastListScreen.swift
//  OTTPlatform
//
//  Created by Apple8 on 18/03/25.
//

import SwiftUI

struct CastListScreen: View {
    var castDetails: [CastMember]
    var body: some View {
        VStack {
            HStack {
                Text(.localizedKey("cast_details"))
                    .roundedText(.subheadline, .bold)
                    .foregroundStyle(.white)
                Spacer()
                Button {
                    
                } label: {
                    HStack {
                        Text(.localizedKey("see_all"))
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(Color.gradientColor)
                    .roundedText(.subheadline, .bold)
                }

            }
            .padding(.horizontal)
            LazyStackView(items: castDetails, isHorizontal: true, spacing: 4, neededFrame: 3.8) { item in
                getCastList(item)
            }
            .frame(maxWidth: .infinity)
            .contentMargins(.horizontal, 12)
        }
    }
}

#Preview {
    CastListScreen(castDetails: MockDetails.shared.getMockCast())
}

extension CastListScreen {
    func getCastList(_ castMember: CastMember) -> some View {
        VStack {
            Image(castMember.imageURL)
                .resizableFit()
                .frame(width: 90, height: 90)
            Text(castMember.name)
                .foregroundStyle(.white)
            Text(castMember.role)
                .foregroundStyle(.gray)
        }
        .lineLimit(1)
        .roundedText(.footnote, .bold)
    }
}
