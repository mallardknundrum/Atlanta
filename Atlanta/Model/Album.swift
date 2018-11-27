//
//  Album.swift
//  Atlanta
//
//  Created by Jeremiah Hawks on 11/27/18.
//  Copyright © 2018 Jeremiah Hawks. All rights reserved.
//

import Foundation

class Album {
    
    let name: String
    let artist: String
    let URLString: String
    let thumbnailImageURLString: String
    let imageURLString: String
    let id: String
    
    init(name: String, URLString: String, artist: String, thumbnailImageURLString: String, imageURLString: String, id: String) {
        self.name = name
        self.artist = artist
        self.URLString = URLString
        self.thumbnailImageURLString = thumbnailImageURLString
        self.imageURLString = imageURLString
        self.id = id
    }
    
    init?(from json: [String: Any]) {
        guard let name = json["name"] as? String,
            let URLString = json["url"] as? String,
            let imageDictionary = json["image"] as? [[String: String]],
            let artist = json["artist"] as? String,
            let id = json["mbid"] as? String else { return nil}
        var thumbnailString = ""
        var imageString = ""
        for dictionary in imageDictionary {
            if dictionary["size"] == "small", let size  = dictionary["#text"] {
                thumbnailString = size
            }
            if dictionary["size"] == "large", let size  = dictionary["#text"] {
                imageString = size
            }
        }
        self.name = name
        self.artist = artist
        self.URLString = URLString
        self.thumbnailImageURLString = thumbnailString
        self.imageURLString = imageString
        self.id = id
    }
}
