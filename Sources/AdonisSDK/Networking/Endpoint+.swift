//
//  Endpoint+.swift
//  AdonisDemoApp
//
//  Created by Kemal Türk on 30.09.2023.
//

import Foundation
import HttpKit

let BASE_URL = "l4fsauu8dc.execute-api.us-east-1.amazonaws.com"

extension Endpoint {
    
    var scheme: String { "https" }
    var host: String { BASE_URL }
    var middlePath: String { "/prod/" }
    
}
