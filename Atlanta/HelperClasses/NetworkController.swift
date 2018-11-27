//
//  NetworkController.swift
//  Atlanta
//
//  Created by Jeremiah Hawks on 11/27/18.
//  Copyright © 2018 Jeremiah Hawks. All rights reserved.
//

import Foundation

class NetworkController {
    
    // MARK: Properties
    
    private let APIKey = "2a35a7fa406f29d7773c61f278f15646"
    private let jsonString = "json"
    private let APISharedSecret = "fa7f50ba0dc534927c18772a7f02e573"
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Patch = "PATCH"
        case Delete = "DELETE"
    }
    
    static func performRequest(for url: URL,
                               httpMethod: HTTPMethod,
                               urlParameters: [String : String]? = nil,
                               body: Data? = nil,
                               completion: ((Data?, Error?) -> Void)? = nil) {
        
        // Build our entire URL
        
        let requestURL = self.url(byAdding: urlParameters, to: url)
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        // Create and "resume" (a.k.a. run) the task
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            completion?(data, error)
        }
        
        dataTask.resume()
    }
    
    static func url(byAdding parameters: [String : String]?,
                    to url: URL) -> URL {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if parameters != nil {
            components?.queryItems = parameters?.compactMap({ URLQueryItem(name: $0.0, value: $0.1) })
            components?.queryItems?.append(URLQueryItem(name: "api_key", value: NetworkController().APIKey))
            components?.queryItems?.append(URLQueryItem(name: "format", value: NetworkController().jsonString))
            components?.queryItems?.append(URLQueryItem(name: "limit", value: "20"))
        }
        
        guard let url = components?.url else {
            fatalError("URL optional is nil")
        }
        return url
    }
}
