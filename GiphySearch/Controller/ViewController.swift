//
//  ViewController.swift
//  GiphySearch
//
//  Created by Aman Meena on 07/05/20.
//  Copyright © 2020 Aman Meena. All rights reserved.
//

import UIKit
//import GiphyUISDK
//import GiphyCoreSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK:- Properties
    
    let reuseID = "gifCell"
    var network = GifNetwork()
    var gifs: [Gif] = []
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK:- Methods
    
    func setup() {
        
        // UITableView
//        tableView.dataSource = self
//        tableView.delegate = self
//
        // UISearchBar
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.placeholder = "What's your favourite gif?"
        searchBar.returnKeyType = .search
    }
    
    /**
    Fetches gifs based on the search term and populates tableview
    - Parameter searchTerm: The string to search gifs of
    */
    func fetchGifs(for searchText: String) {
        network.fetchGifs(searchTerm: searchText) { gifArray in
            if gifArray != nil {
                self.gifs = gifArray!.gifs
                self.tableView.reloadData()
            }
        }
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! GifCell
        cell.gif = gifs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

    
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if let searchText = textField.text {
            fetchGifs(for: searchText)
            return true
        }
        return false
    }
}

