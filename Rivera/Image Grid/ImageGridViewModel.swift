//
//  ImageGridViewModel.swift
//  Rivera
//
//  Created by Kyle Rohr on 22/9/20.
//

import Foundation
import Combine

class ImageGridViewModel: ObservableObject {

    @Published var images = [RemoteImage]()

    private var imageApi: ImageApiImpl
    private var cancellables = Set<AnyCancellable>()

    init(imageApi: ImageApiImpl) {
        self.imageApi = imageApi

        self.reloadImages()
    }

    func reloadImages() {
        imageApi.getImages()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let imageError):
                    switch imageError {
                    case .decodingError(let error):
                        print("Decoding error: \(error.localizedDescription)")
                    case .sessionError(let error):
                        print("Session error: \(error.localizedDescription)")
                    default:
                        print("Unknown error.")
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] value in
                guard let self = self else { return }

                self.images = value
            }
            .store(in: &cancellables)

    }

}
