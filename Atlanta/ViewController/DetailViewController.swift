//
//  DetailViewController.swift
//  Atlanta
//
//  Created by Jeremiah Hawks on 11/27/18.
//  Copyright © 2018 Jeremiah Hawks. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlButton: UIButton!
    @IBAction func goToWebsite(_ sender: Any) {
        guard let urlString = urlButton.titleLabel?.text, let url = URL(string: urlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    var artist: Artist?
    var album: Album?
    var song: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        switch (artist == nil, album == nil, song == nil) {
        case (false, true, true):
            guard let artist = artist else { return }
            titleLabel.text = "Artist"
            nameLabel.text = artist.name
            urlButton.setTitle(artist.URLString, for: .normal)
            ImageController().getImage(from: artist.imageURLString) { (image) in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        case (true, false, true):
            guard let album = album else { return }
            titleLabel.text = "Artist: \(album.artist)"
            nameLabel.text = "Album: \(album.name)"
            urlButton.setTitle(album.URLString, for: .normal)
            ImageController().getImage(from: album.imageURLString) { (image) in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        case(true, true, false):
            guard let song = song else { return }
            titleLabel.text = "Artist: \(song.artist)"
            nameLabel.text = "Song: \(song.name)"
            urlButton.setTitle(song.URLString, for: .normal)
            ImageController().getImage(from: song.imageURLString) { (image) in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        default: return
        }
    }
}

