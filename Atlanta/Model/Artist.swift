//
//  Artist.swift
//  Atlanta
//
//  Created by Jeremiah Hawks on 11/27/18.
//  Copyright © 2018 Jeremiah Hawks. All rights reserved.
//

import Foundation

class Artist {
    
    let name: String
    let URLString: String
    let thumbnailImageURLString: String
    let imageURLString: String
    let id: String
    
    init(name: String, URLString: String, thumbnailImageURLString: String, imageURLString: String, id: String) {
        self.name = name
        self.URLString = URLString
        self.thumbnailImageURLString = thumbnailImageURLString
        self.imageURLString = imageURLString
        self.id = id
    }
}
