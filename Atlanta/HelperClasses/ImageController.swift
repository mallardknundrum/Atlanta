//
//  ImageController.swift
//  Atlanta
//
//  Created by Jeremiah Hawks on 11/27/18.
//  Copyright © 2018 Jeremiah Hawks. All rights reserved.
//

import UIKit

class ImageController {
    
    func getImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else { completion(nil); return }
        NetworkController.performRequest(for: url, httpMethod: .Get) { (optionalData: Data?, optionalError: Error?) in
            print(url)
            if let error = optionalError {
                print(error.localizedDescription)
            }
            guard let data = optionalData, let image = UIImage(data: data) else { completion(nil); return }
            completion(image)
            return
        }
    }
}
