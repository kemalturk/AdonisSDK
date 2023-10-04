//
//  AdonisEndpoint.swift
//  AdonisDemoApp
//
//  Created by Kemal Türk on 30.09.2023.
//

import Foundation
import HttpKit


enum AdonisEndpoint {
    case view
    case clickEvent(id: String)
}

extension AdonisEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .view:
            return "/view"
        case .clickEvent:
            return "/click-event"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .clickEvent:
            return .post
        case .view:
            return .get
        }
    }
    
    var header: [String : String]? {
        ["Api-Key": API_KEY]
    }
    
    var query: [String : String]? {
        switch self {
        case .view:
            let bundleID = Bundle.main.bundleIdentifier ?? ""
            return ["bundle": bundleID]
        default:
            return nil
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .clickEvent(let id):
            let bundleID = Bundle.main.bundleIdentifier ?? ""
            return ["id": id, "bundle": bundleID]
        default:
            return nil
        }
    }
    
}
