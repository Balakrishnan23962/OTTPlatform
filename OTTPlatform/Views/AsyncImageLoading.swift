//
//  AsyncImageLoading.swift
//  OTTPlatform
//
//  Created by Apple8 on 19/03/25.
//

import Foundation

import SwiftUI

struct AsyncImageLoading: View {
    var urlString: String
    var size: CGSize
    @State private var imageData: Data? = nil
    var body: some View {
        GeometryReader {
            Group {
                if let data = imageData, let uiImage = UIImage(data: data) {
                    DownSizedImage(image: uiImage, size: size) { image in
                        image
                            .resizable()
                    }
                } else {
                    Color.gray.opacity(0.5)
                }
            }
            .frame(width: $0.size.width, height: $0.size.height)
        }
        .task {
            await loadImage()
        }
    }
    @MainActor
        private func loadImage() async {
            guard let data = await urlString.getData() else { return }
            imageData = data
        }
}

struct DownSizedImage<Content: View>: View {
    var image: UIImage?
    var size: CGSize
    @ViewBuilder var content: (Image) -> Content
    @State private var reSizedImage: Image?
    var body: some View {
        ZStack {
            if let reSizedImage {
                content(reSizedImage)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            guard reSizedImage == nil else { return }
            createDownSizedImage(image)
        }
        .onChange(of: image) { oldValue, newValue in
            guard oldValue != newValue else { return }
            createDownSizedImage(newValue)
        }
    }
    
    private func createDownSizedImage(_ image: UIImage?) {
        guard let image else { return }
        let size = image.size.aspectFit(size)
        let gImage = UIGraphicsImageRenderer(size: size)
        Task.detached(priority: .high) {
            let resizeImage = gImage.image { context in
                image.draw(in: .init(origin: .zero, size: size))
            }
            await MainActor.run {
                reSizedImage = .init(uiImage: resizeImage)
            }
        }
    }
}

extension CGSize {
    func aspectFit(_ to: CGSize) -> CGSize {
        let scaleX = to.width / width
        let scaleY = to.height / height
        let aspectFit = min(scaleX, scaleY)
        return .init(width: aspectFit * width, height: aspectFit * height)
    }
}


extension String {
    func getData() async -> Data? {
        guard let url = URL(string: self) else { return nil }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else { return nil }
            return data
        } catch {
            return nil
        }
    }
}


