// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

var API_KEY = ""

public class AdonisSDK {
    
    public static var BANNER_HEIGHT: CGFloat = 50
    
    public static func initialize(with apiKey: String) {
        API_KEY = apiKey
    }
    
}
