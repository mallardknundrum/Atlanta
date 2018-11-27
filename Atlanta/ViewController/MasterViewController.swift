//
//  MasterViewController.swift
//  Atlanta
//
//  Created by Jeremiah Hawks on 11/27/18.
//  Copyright © 2018 Jeremiah Hawks. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var artists: [Artist] =  [Artist(name: "someone", URLString: "aURL", thumbnailImageURLString: "thumbnailURL", imageURLString: "imageURL", id: "000")]
    var albums: [Album] = [Album(name: "album", URLString: "url", artist: "artist name", thumbnailImageURLString: "thumbnailURL", imageURLString: "imageURL", id: "000")]
    var songs: [Song] = [Song(name: "song", URLString: "url", artist: "artist name", thumbnailImageURLString: "thumbnailURL", imageURLString: "imageURL", id: "000")]
    let searchController = UISearchController(searchResultsController: nil)
    var artistSearchResultsPage: Int? = nil
    var artistTotalResults = 1
    var albumSearchResultsPage: Int? = nil
    var albumTotalResults = 1
    var songSearchResultsPage: Int? = nil
    var songTotalResults = 1
    var dataSource = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.leftBarButtonItem = editButtonItem
        
        setUpSearchController()

//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
//        if let split = splitViewController {
//            let controllers = split.viewControllers
//            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            // need to switch on section
            guard let indexPath = tableView.indexPathForSelectedRow, let destination = segue.destination.children[0] as? DetailViewController else { return }
            switch dataSource {
            case 0: destination.artist = artists[indexPath.row]
            case 1: destination.album = albums[indexPath.row]
            case 2: destination.song = songs[indexPath.row]
            default: return
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataSource {
        case 0: return artists.count
        case 1: return albums.count
        case 2: return songs.count
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        switch dataSource {
        case 0:
            let artist = artists[indexPath.row]
            cell.textLabel?.text = "Artist"
            cell.detailTextLabel?.text = artist.name
            cell.imageView?.image = UIImage(named: "DefaultArtist")
            ImageController().getImage(from: artist.thumbnailImageURLString) { (optionalImage: UIImage?) in
                if let image = optionalImage {
                    DispatchQueue.main.async {
                        cell.imageView?.image = image
                    }
                }
            }
            // get image
        case 1:
            let album = albums[indexPath.row]
            cell.textLabel?.text = "Album Title: \(album.name)"
            cell.detailTextLabel?.text = "Artist: \(album.artist)"
            cell.imageView?.image = UIImage(named: "DefaultAlbum")
            ImageController().getImage(from: album.thumbnailImageURLString) { (optionalImage: UIImage?) in
                if let image = optionalImage {
                    DispatchQueue.main.async {
                        cell.imageView?.image = image
                    }
                }
            }
            // get image
        case 2:
            let song = songs[indexPath.row]
            cell.textLabel?.text = "Song Title: \(song.name)"
            cell.detailTextLabel?.text = "Artist: \(song.artist)"
            cell.imageView?.image = UIImage(named: "DefaultSong")
            ImageController().getImage(from: song.thumbnailImageURLString) { (optionalImage: UIImage?) in
                if let image = optionalImage {
                    DispatchQueue.main.async {
                        cell.imageView?.image = image
                    }
                }
            }

            // get image
        default:
            return cell // should never get here
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastArtistIndexPath = IndexPath(row: artists.count - 1, section: 0)
        let lastAlbumIndexPath = IndexPath(row: albums.count - 1, section: 0)
        let lastSongIndexPath = IndexPath(row: songs.count - 1, section: 0)
        guard let searchTerm = searchController.searchBar.text, !searchTerm.isEmpty else { return }
        if indexPath == lastArtistIndexPath && artists.count >= artistTotalResults {
            search(artist: searchTerm)
        }
        if indexPath == lastAlbumIndexPath && albums.count >= albumTotalResults {
            search(album: searchTerm)
        }
        if indexPath == lastSongIndexPath && songs.count >= songTotalResults {
            search(song: searchTerm)
        }
    }
    
    // MARK: - Helper Functions
    
    private func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
//        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = ["Artist", "Album", "Song"]
        searchController.searchBar.placeholder = "Search last.fm"
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.showsScopeBar = true
        
    }
    
    func search(text: String?) {
        search(artist: text)
        search(album: text)
        search(song: text)
    }
    
    func search(artist: String?) {
        guard let artist = artist else { return }
        ArtistController().search(for: artist, pageNumber: artistSearchResultsPage ?? 0 + 1) { (artistsArray, returnedPageNumber, totalResults) in
            self.artistSearchResultsPage = returnedPageNumber
            self.artistTotalResults = totalResults
            if self.artists.isEmpty {
                self.artists = artistsArray
            } else {
                self.artists.append(contentsOf: artistsArray)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func search(album: String?) {
        guard let album = album else { return }
        AlbumController().search(for: album, pageNumber: albumSearchResultsPage ?? 0 + 1) { (albumsArray, returnedPageNumber, totalResults) in
            self.albumSearchResultsPage = returnedPageNumber
            self.albumTotalResults = totalResults
            if self.albums.isEmpty {
                self.albums = albumsArray
            } else {
                self.albums.append(contentsOf: albumsArray)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func search(song: String?) {
        guard let song = song else { return }
        SongController().search(for: song, pageNumber: songSearchResultsPage ?? 0 + 1) { (songsArray, returnedPageNumber, totalResults) in
            self.songSearchResultsPage = returnedPageNumber
            self.songTotalResults = totalResults
            if self.songs.isEmpty {
                self.songs = songsArray
            } else {
                self.songs.append(contentsOf: songsArray)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func resetDataSource() {
        albumSearchResultsPage = nil
        artistSearchResultsPage = nil
        songSearchResultsPage = nil
        artists = []
        albums = []
        songs = []
    }
    
}

extension MasterViewController: UISearchResultsUpdating {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resetDataSource()
        search(text: searchController.searchBar.text)
    }
    func updateSearchResults(for searchController: UISearchController) {
       
    }
}

extension MasterViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        dataSource = selectedScope
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetDataSource()
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

