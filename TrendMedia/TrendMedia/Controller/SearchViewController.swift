//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by 박연배 on 2021/10/15.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK: Property
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색"
        return searchBar
    }()
    
    //MARK: Method
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = searchBar
    }
    
}
