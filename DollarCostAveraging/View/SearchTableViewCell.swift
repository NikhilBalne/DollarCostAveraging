//
//  SearchTableViewCell.swift
//  DollarCostAveraging
//
//  Created by Nikhilkumar Balne on 17/04/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var assetSymbolLabel: UILabel!
    @IBOutlet weak var assetTypeLabel: UILabel!
    @IBOutlet weak var assetNameLabel: UILabel!

    func configureCell(with searchResult:SearchResult){
        assetNameLabel.text = searchResult.name
        assetSymbolLabel.text = searchResult.symbol
        assetTypeLabel.text = searchResult.type.appending("").appending(searchResult.currency)
    }
}
