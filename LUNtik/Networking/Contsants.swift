//
//  Contsants.swift
//  LUNtik
//
//  Created by Nikandr Marhal on 18.01.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseUrl = "https://luntik-test.herokuapp.com/"
    }
    
    enum ResidenceJsonKeys: String {
        case imageURL = "image_url"
        case address
        case name
        case longitude
        case latitude
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
