//
//  ImageLoader.swift
//  LUNtik
//
//  Created by Nikandr Marhal on 17.01.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

enum ImageLoadError: Error {
    case loadingFailed(String)
}

class ImageLoader {
    static func downloadImage(from url: URL, completion: @escaping (Result<Data, ImageLoadError>) -> Void) {
        ImageLoader.getData(from: url) { data, response, error in
            var result: Result<Data, ImageLoadError>!
            if let error = error {
                result = .failure(.loadingFailed(error.localizedDescription))
            } else if let data = data {
                result = .success(data)
            }
            completion(result)
        }
    }
    
    private static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
