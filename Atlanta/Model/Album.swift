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
}
