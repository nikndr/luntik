//
//  Residence.swift
//  LUNtik
//
//  Created by Nikandr Marhal on 17.01.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import MapKit

class Residence: NSObject, MKAnnotation {
    let title: String?
    let address: String
    let imageURL: String
    let coordinate: CLLocationCoordinate2D
    var selected: Bool
    
    init(title: String?, address: String, coordinate: CLLocationCoordinate2D, imageURL: String) {
        self.title = title
        self.address = address
        self.coordinate = coordinate
        self.imageURL = imageURL
        self.selected = false
        
        super.init()
    }
}
