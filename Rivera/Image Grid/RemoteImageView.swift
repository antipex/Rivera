//
//  AsyncImage.swift
//  Rivera
//
//  Created by Kyle Rohr on 22/9/20.
//

import SwiftUI

struct RemoteImageView<Placeholder: View>: View {

    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder?

    init(url: URL, placeholder: Placeholder? = nil) {
        loader = ImageLoader(url: url)
        self.placeholder = placeholder
    }

    var body: some View {
        imageView
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }

    private var imageView: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped(antialiased: true)
            } else {
                placeholder
            }
        }
    }

}
