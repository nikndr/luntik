//
//  APIRouter.swift
//  LUNtik
//
//  Created by Nikandr Marhal on 18.01.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    case buildings
    
    var method: HTTPMethod {
        switch self {
        case .buildings:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .buildings:
            return "/buildings"
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        return urlRequest
    }
}
