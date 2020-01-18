//
//  ImageLoader.swift
//  LUNtik
//
//  Created by Nikandr Marhal on 17.01.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

enum ImageLoadError: Error {
    case loadingFailed(String)
}

class ImageLoader {
    static func downloadImage(from url: URL, completion: @escaping (Result<Data, ImageLoadError>) -> Void) {
        AF.request(url).responseData { response in
            var result: Result<Data, ImageLoadError>!
            if let error = response.error {
                result = .failure(.loadingFailed(error.localizedDescription))
            } else if let data = response.data {
                result = .success(data)
            }
            completion(result)
        }
    }
}
