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
    var objects = [Any]()
    var artists: [Artist] =  [Artist(name: "someone", URLString: "aURL", thumbnailImageURLString: "thumbnailURL", imageURLString: "imageURL", id: "000")]
    var albums: [Album] = [Album(name: "album", URLString: "url", artist: "artist name", thumbnailImageURLString: "thumbnailURL", imageURLString: "imageURL", id: "000")]
    var songs: [Song] = [Song(name: "song", URLString: "url", artist: "artist name", thumbnailImageURLString: "thumbnailURL", imageURLString: "imageURL", id: "000")]
    var dataSource: [[Any]] = []
    let searchController = UISearchController(searchResultsController: nil)
    var artistSearchResultsPage: Int? = nil
    var artistTotalSearchResultPages = 1
    var albumSearchResultsPage: Int? = nil
    var albumTotalSearchResultPages = 1
    var songSearchResultsPage: Int? = nil
    var songTotalSearchResultPages = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = [artists, albums, songs]
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

    @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            // need to switch on section
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                // I can switch what controller I make based on section here... as! detail or as! whateverIWant
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        switch indexPath.section {
        case 0:
            guard let artist = dataSource[indexPath.section][indexPath.row] as? Artist else { return cell }
            cell.textLabel?.text = "Artist"
            cell.detailTextLabel?.text = artist.name
            cell.imageView?.image = UIImage(named: "DefaultAlbum")
            // get image
        case 1:
            guard let album = dataSource[indexPath.section][indexPath.row] as? Album else { return cell }
            cell.textLabel?.text = "Album Title: \(album.name)"
            cell.detailTextLabel?.text = "Artist: \(album.artist)"
            cell.imageView?.image = UIImage(named: "DefaultArtist")
            // get image
        case 2:
            guard let song = dataSource[indexPath.section][indexPath.row] as? Song else { return cell }
            cell.textLabel?.text = "Song Title: \(song.name)"
            cell.detailTextLabel?.text = "Artist: \(song.artist)"
            cell.imageView?.image = UIImage(named: "DefaultSong")

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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
        case 1:
            return
        case 2:
            return
        default:
            return
        }
    }
    
    // MARK: - Helper Functions
    
    private func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = ["Artist", "Album", "Song"]
        searchController.searchBar.placeholder = "Search last.fm"
    }
    
//    func search(for artist: String?) -> ([Artist], pageNumber: Int, numberOfPages: Int) {
//    
//    }
    
    
}

extension MasterViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        albumSearchResultsPage = nil
        artistSearchResultsPage = nil
        songSearchResultsPage = nil
        // preform searches here
    }
}

extension MasterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        // I need to scroll to the Artist, Album, or Song sections here
    }

}

