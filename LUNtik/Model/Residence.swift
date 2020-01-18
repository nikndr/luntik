//
//  Residence.swift
//  LUNtik
//
//  Created by Nikandr Marhal on 17.01.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import MapKit

struct Residence {
    let title: String?
    let address: String
    let imageURL: String
    let lat: Double
    let long: Double
}

extension Residence: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case address
        case imageURL
        case lat
        case long
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title: String? = try container.decode(String?.self, forKey: .title)
        let address: String = try container.decode(String.self, forKey: .address)
        let imageURL: String = try container.decode(String.self, forKey: .imageURL)
        let lat: Double = try container.decode(Double.self, forKey: .lat)
        let long: Double = try container.decode(Double.self, forKey: .long)
        
        self.init(title: title, address: address, imageURL: imageURL, lat: lat, long: long)
    }
    
}

class ResidenceAnnotation: NSObject, MKAnnotation {
    let residence: Residence
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(fromResidence residence: Residence) {
        self.residence = residence
        self.title = self.residence.title ?? "Житловий комплекс"
        self.coordinate = CLLocationCoordinate2D(latitude: self.residence.lat, longitude: self.residence.long)
        super.init()
    }
}


