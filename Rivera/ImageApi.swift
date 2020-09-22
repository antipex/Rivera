//
//  ImageApi.swift
//  Rivera
//
//  Created by Kyle Rohr on 22/9/20.
//

import Foundation
import Combine

enum ImageApiError: Error {

    case unknown
    case sessionError(error: Error)
    case decodingError(error: Error)

}

protocol ImageApiImpl {

    func getImages() -> AnyPublisher<[RemoteImage], ImageApiError>

}

class ImageApi: ImageApiImpl {

    func getImages() -> AnyPublisher<[RemoteImage], ImageApiError> {
        guard var components = URLComponents(url: URL(string: Rivera.Api.url)!, resolvingAgainstBaseURL: false) else {
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }

        components.queryItems = [URLQueryItem(name: "key", value: Rivera.Api.key)]

        let url = components.url!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .mapError({ error -> ImageApiError in
                ImageApiError.sessionError(error: error)
            })
            .decode(type: [String: [String: RemoteImage]].self, decoder: JSONDecoder())
            .map({ rootDict -> [RemoteImage] in
                guard let imageDicts = rootDict["images"] else { return [] }

                return imageDicts.compactMap { imageDict -> RemoteImage in
                    var mutableImage = imageDict.value

                    mutableImage.id = UUID(uuidString: imageDict.key)!

                    return mutableImage
                }
            })
            .mapError { error -> ImageApiError in
                ImageApiError.decodingError(error: error)
            }
            .eraseToAnyPublisher()
    }

}
