//
//  ViewResponse.swift
//  AdonisDemoApp
//
//  Created by Kemal Türk on 30.09.2023.
//

import Foundation


struct ViewResponse: Decodable {
    let id: String?
    let image: String?
    let url: String?
    let appID: String?
    
    enum CodingKeys: String, CodingKey {
        case id, image, url
        case appID = "app_id"
    }
}
