//
//  ImageLoader.swift
//  Rivera
//
//  Created by Kyle Rohr on 22/9/20.
//

import UIKit
import Combine

class ImageLoader: ObservableObject {

    @Published var image: UIImage?
    private let url: URL

    private var cancellable: AnyCancellable?

    init(url: URL) {
        self.url = url
    }

    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    func cancel() {
        cancellable?.cancel()
    }

}
