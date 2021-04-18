//
//  APIService.swift
//  DollarCostAveraging
//
//  Created by Nikhilkumar Balne on 18/04/21.
//

import Foundation
import Combine

struct APIService {
    
    let keys = ["Y6YJF9VQPF4MWYEF", "JDFKPHLVMVHH6ZNW", "BIVKCG7LC48QC62Y"]
    
    var API_KEY: String {
        return keys.randomElement() ?? ""
    }
    
    func fetchSymbolPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
     
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
    
        let url = URL(string: urlString)!
        debugPrint("URL:\(url)")
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
