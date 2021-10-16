//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by 박연배 on 2021/10/15.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    //MARK: Property
    
    var movies = [Movie]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        df.locale = Locale(identifier: "ko-KR")
        df.timeZone = TimeZone(identifier: "KST")
        
        return df
    }()
    
    
    //MARK: Method
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarConfig() {
        searchBar.searchTextField.borderStyle = .none
        searchBar.backgroundImage = UIImage()
        searchBar.layer.cornerRadius = 10
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .darkGray
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarConfig()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "AccentColor")
    }
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTableViewCell", for: indexPath) as? MovieDetailTableViewCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
        
        cell.title.text = "\(movie.korTitle!)(\(movie.engTitle!))"
        cell.title.textColor = .white
        
        cell.poster.image = UIImage(named: movie.image!)
        
        cell.story.text = movie.story!
        
        cell.releaseDate.text = dateFormatter.string(from: movie.releaseDate!) + " | "  + "\(movie.country!)"
        
        cell.backgroundColor = UIColor(named: "AccentColor")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UIScreen.main.bounds.height * 0.2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
