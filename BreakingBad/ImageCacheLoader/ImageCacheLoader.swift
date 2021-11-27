//
//  ImageCacheLoader.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 26/11/2021.
//

import Foundation
import UIKit

protocol ImageCacheLoader {
    func image(forURL url: URL) async throws -> UIImage?
}

class ImageCacheLoaderURLSession: ImageCacheLoader {

    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func image(forURL url: URL) async throws -> UIImage? {
        let (data, response) = try await urlSession.data(for: URLRequest(url: url))
        try response.throwOnFailureStatusCode()
        return UIImage(data: data)
    }

}
