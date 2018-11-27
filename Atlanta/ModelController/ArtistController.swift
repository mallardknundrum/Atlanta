//
//  ArtistController.swift
//  Atlanta
//
//  Created by Jeremiah Hawks on 11/27/18.
//  Copyright © 2018 Jeremiah Hawks. All rights reserved.
//

import Foundation

class ArtistController {
    
    private let methodAPIKey = "method"
    private let artistAPIKey = "artist"
    private let artistMethodAPIParamaterValue = "artist.search"
    
    
    func search(for artist: String, pageNumber: Int?) -> [Artist] {
        guard let url = URL(string:Constants.APIBaseURL) else { return [] }
        var params = [methodAPIKey: artistMethodAPIParamaterValue,
                      artistAPIKey: artist]
        if let pageNumber = pageNumber {
            params[Constants.APIPageNumberKey] = String(pageNumber)
        }
//        NetworkController.performRequest(for: <#T##URL#>, httpMethod: <#T##NetworkController.HTTPMethod#>, urlParameters: <#T##[String : String]?#>, body: <#T##Data?#>, completion: <#T##((Data?, Error?) -> Void)?##((Data?, Error?) -> Void)?##(Data?, Error?) -> Void#>)
        return []
    }
}
