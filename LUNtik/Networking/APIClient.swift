//
//  APIClient.swift
//  LUNtik
//
//  Created by Nikandr Marhal on 17.01.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class APIClient {
    static func getResidenceData(completion: @escaping (Result<[Residence], AFError>) -> Void) { //TODO: custom error
        AF.request(APIRouter.buildings).responseJSON { response in
            var result: Result<[Residence], AFError>!
            if let value = response.value {
                let json = JSON(value)
                let residences = json.array!.map { json -> Residence in
                    let title = json[K.ResidenceJsonKeys.name.rawValue].string!.isEmpty
                        ? nil
                        : json[K.ResidenceJsonKeys.name.rawValue].string!
                    let address = json[K.ResidenceJsonKeys.address.rawValue].string!
                    let imageURL = json[K.ResidenceJsonKeys.imageURL.rawValue].string!
                    let lat = json[K.ResidenceJsonKeys.latitude.rawValue].double!
                    let lon = json[K.ResidenceJsonKeys.longitude.rawValue].double!
                    return Residence(title: title, address: address, imageURL: imageURL, lat: lat, long: lon)
                }
                result = .success(residences)
            } else if let error = response.error {
                result = .failure(error)
            }
            completion(result)
        }
    }
}
