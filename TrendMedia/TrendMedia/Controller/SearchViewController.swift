//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by 박연배 on 2021/10/15.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    
    
    //MARK: Property
    
    var searchTimer: Timer?
    
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
    
    func searchStart() {
//        searchResult = movies.filter( { ($0.korTitle! + $0.engTitle!).lowercased().contains(searchBar.text!)} )
//        print(searchResult)
    }
    
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
        searchBar.searchTextField.textColor = .white
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
    }
    
    func fetchMovieData() {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        
        guard let query = searchText.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed) else {
            return
        }
        
        let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=10&start=1"
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "lmgRVJ52MggB1oBFxsdg",
            "X-Naver-Client-Secret": "7c3CdQ6YiR"
        ]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
//                for item in json["items"].arrayValue {
//                    let value = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
//                    let image = item["image"].stringValue
//                    let link = item["link"].stringValue
//                    let rating = item["userRating"].stringValue
//                    let sub = item["subTitle"].stringValue
//
//
//                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarConfig()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "AccentColor")
        
        searchBar.delegate = self
        
        let gesture = UITapGestureRecognizer()
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        
        fetchMovieData()
    }
    
}

//MARK: Extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTableViewCell", for: indexPath) as? MovieDetailTableViewCell else {
            return UITableViewCell()
        }
    
//        var movie = movies[indexPath.row]
        
        
//        cell.title.text = "\(movie.korTitle!)(\(movie.engTitle!))"
//        cell.title.textColor = .white
//
//        cell.poster.image = UIImage(named: movie.image!)
//
//        cell.story.text = movie.story!
//
//        cell.releaseDate.text = dateFormatter.string(from: movie.releaseDate!) + " | "  + "\(movie.country!)"
//
//        cell.backgroundColor = UIColor(named: "AccentColor")
//
//        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UIScreen.main.bounds.height * 0.2
    }
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        print(indexPath)
        return nil
    }
    
    
}

//MARK: SearchBar delegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchTimer?.invalidate()
        self.searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { timer in
            self.searchStart()
            
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchStart()
        
        fetchMovieData()
        searchBar.resignFirstResponder()
    }
    
}

//MARK: gesture Recogniger delegate
extension SearchViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if !touch.view!.isDescendant(of: searchBar) {
            self.searchBar.resignFirstResponder()
            return false
        }
        return false
    }
}
