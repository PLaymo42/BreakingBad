//
//  Dependencies.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 29/11/2021.
//

import Foundation

enum Dependencies {

    static let imageFetcher: ImageCacheLoader = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = .shared
        let urlSession = URLSession(configuration: configuration)
        return ImageCacheLoaderURLSession(
            urlSession: urlSession
        )
    }()

}
