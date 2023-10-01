//
//  Endpoint+.swift
//  AdonisDemoApp
//
//  Created by Kemal Türk on 30.09.2023.
//

import Foundation
import HttpKit

let BASE_URL = "127.0.0.1:3000"

extension Endpoint {
    
    var scheme: String { "http" }
    var host: String { BASE_URL }
    
}
