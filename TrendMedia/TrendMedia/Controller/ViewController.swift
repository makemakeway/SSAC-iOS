//
//  ViewController.swift
//  TrendMedia
//
//  Created by 박연배 on 2021/10/15.
//

import UIKit

class ViewController: UIViewController {
    
    var movies = [Movie]()

    //MARK: Property
    lazy var searchButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonClicked(_:)))
        button.tintColor = UIColor.systemGray4
        
        return button
    }()
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        df.locale = Locale(identifier: "ko-KR")
        df.timeZone = TimeZone(identifier: "KST")
        
        return df
    }()
    
    @IBOutlet weak var headerStackView: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Method
    
    func headerStackViewConfig() {
        headerStackView.layer.cornerRadius = 15
        headerStackView.layer.shadowColor = UIColor.black.cgColor
        headerStackView.layer.shadowOpacity = 0.3
        headerStackView.layer.shadowOffset = CGSize.zero
    }
    
    func fetchMockData() {
        movies.append(Movie(engTitle: "Alice In Borderland", korTitle: "앨리스 인 보더랜드", genre: "생존", image: "alice_in_borderland", rate: 3.3, releaseDate: Date()))
    }
    
    
    //MARK: Objc func
    
    @objc func searchButtonClicked(_ sender: UIBarButtonItem) {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.view.backgroundColor = .red
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = searchButton
        headerStackViewConfig()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchMockData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.containerView.layer.shadowOffset = CGSize.zero
        cell.containerView.layer.shadowColor = UIColor.black.cgColor
        cell.containerView.layer.shadowOpacity = 0.5
        cell.containerView.layer.shadowRadius = 10
        cell.containerView.layer.cornerRadius = 10
        cell.posterImage.layer.cornerRadius = 10
        cell.posterImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let movieData = movies[indexPath.row]
        
        cell.posterImage.image = UIImage(named: movieData.image)
        
        cell.engTitle.text = movieData.engTitle
        cell.engTitle.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    
        cell.korTitle.text = movieData.korTitle
        cell.korTitle.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        cell.genreLabel.text = movieData.genre
        
        let dateString = dateFormatter.string(from: movieData.releaseDate)
        cell.releaseDate.text = dateString
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UIScreen.main.bounds.height * 0.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
