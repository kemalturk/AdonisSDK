//
//  AdonisEndpoint.swift
//  AdonisDemoApp
//
//  Created by Kemal Türk on 30.09.2023.
//

import Foundation
import HttpKit


enum AdonisEndpoint {
    case check
    case view(id: String)
    case clickEvent(id: String)
}

extension AdonisEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .check:
            return "/check"
        case .view(let id):
            return "/view/\(id)"
        case .clickEvent:
            return "/click-event"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .check, .clickEvent:
            return .post
        case .view:
            return .get
        }
    }
    
    var body: [String : Any]? {
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        switch self {
        case .check:
            return ["bundle": bundleID]
        case .clickEvent(let id):
            return ["id": id, "bundle": bundleID]
        default:
            return nil
        }
    }
    
}
