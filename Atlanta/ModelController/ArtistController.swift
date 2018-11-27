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
    
    
    func search(for artist: String, pageNumber: Int?, completion: (([Artist], _ pageNumber: Int, _ totalResults: Int) -> Void)? = nil) {
        //completion: ((Data?, Error?) -> Void)? = nil)
        guard let url = URL(string:Constants.APIBaseURL) else { completion?([], 0, 0); return }
        var params = [methodAPIKey: artistMethodAPIParamaterValue,
                      artistAPIKey: artist]
        if let pageNumber = pageNumber {
            params[Constants.APIPageNumberKey] = String(pageNumber)
        }
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: params, body: nil) { (optionalData: Data?, optionalError: Error?) in
            if let data = optionalData,
                let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any],
                let resultsDictionary = json["results"] as? [String: Any],
                let queryDictionary = resultsDictionary["opensearch:Query"] as? [String: String],
                let returnedPageNumberString = queryDictionary["startPage"],
                let returnedPageNumber = Int(returnedPageNumberString),
                let artistMatchesDictionary = resultsDictionary["artistmatches"] as? [String: Any],
                let artistsDictionary = artistMatchesDictionary["artist"] as? [[String: Any]],
                let totalResultsString = resultsDictionary["opensearch:totalResults"] as? String,
                let totalResults = Int(totalResultsString)  {
                completion?(artistsDictionary.compactMap ({ Artist(from: $0) }), returnedPageNumber, totalResults)
                return
            }
            print(optionalData)
            print(optionalError)
        }
        completion?([], 0, 0)
        return
    }
}
