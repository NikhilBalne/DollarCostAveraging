//
//  ViewController.swift
//  DollarCostAveraging
//
//  Created by Nikhilkumar Balne on 17/04/21.
//

import UIKit
import Combine

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
    
    private let apiService = APIService()
    private var subscribers = Set<AnyCancellable>()
    @Published private var searchQuery = String()
    private var searchResults: SearchResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavigationHeader()
        observeForm()
    }
    
    private func observeForm() {
        $searchQuery.debounce(for: .milliseconds(750), scheduler: RunLoop.main)
            .sink { [unowned self] (searchQuery) in
                self.apiService.fetchSymbolPublisher(keywords: self.searchQuery).sink { (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .finished: break
                    }
                } receiveValue: { (searchResults) in
                    self.searchResults = searchResults
                    self.tableView.reloadData()
                }.store(in: &self.subscribers)
            }.store(in: &subscribers)
    }
    
    private func setUpNavigationHeader(){
        navigationItem.searchController = searchBar
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SearchTableViewCell
        if let searchResult = self.searchResults {
            cell.configureCell(with: searchResult.items[indexPath.row])
        }
        return cell
    }
}

extension SearchBarViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchResult = searchController.searchBar.text, !searchResult.isEmpty else { return }
        searchQuery = searchResult
    }
}


