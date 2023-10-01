//
//  AdonisClient.swift
//  AdonisDemoApp
//
//  Created by Kemal Türk on 30.09.2023.
//

import Foundation
import HttpKit

protocol AdonisClient {
    func check() async -> FetchState<CheckResponse>
    func sendClickEvent(id: String) async -> FetchState<String>
}

struct AdonisHttpClient: HTTPClient, AdonisClient {
    
    func check() async -> FetchState<CheckResponse> {
        await sendRequest(endpoint: AdonisEndpoint.check).toFetchState()
    }
    
    func sendClickEvent(id: String) async -> FetchState<String> {
        await sendRequest(endpoint: AdonisEndpoint.clickEvent(id: id)).toFetchState()
    }
    
}
