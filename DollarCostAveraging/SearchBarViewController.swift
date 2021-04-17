//
//  ViewController.swift
//  DollarCostAveraging
//
//  Created by Nikhilkumar Balne on 17/04/21.
//

import UIKit

class SearchBarViewController: UITableViewController {

    private lazy var searchBar: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Enter company name or symbol"
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavigationHeader()
    }

    private func setUpNavigationHeader(){
        navigationItem.searchController = searchBar
    }

}

extension SearchBarViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
