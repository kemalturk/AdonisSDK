//
//  AdonisClient.swift
//  AdonisDemoApp
//
//  Created by Kemal Türk on 30.09.2023.
//

import Foundation
import HttpKit

protocol AdonisClient {
    func view() async -> FetchState<ViewResponse>
    func sendClickEvent(id: String) async -> FetchState<String>
}

struct AdonisHttpClient: HTTPClient, AdonisClient {
    
    func view() async -> FetchState<ViewResponse> {
        await sendRequest(endpoint: AdonisEndpoint.view).toFetchState()
    }
    
    func sendClickEvent(id: String) async -> FetchState<String> {
        await sendRequest(endpoint: AdonisEndpoint.clickEvent(id: id)).toFetchState()
    }
    
}
