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
        movies.append(Movie(engTitle: "Alice In Borderland",
                            korTitle: "아리스 인 보더랜드",
                            genre: "생존",
                            image: "alice_in_borderland",
                            rate: 3.3,
                            releaseDate: Date(),
                            story: "이곳은 또 다른 도쿄, 치명적인 게임의 배경. 그 세계로 세 청년이 던져진다. 무의미한 세월을 보내던 게이머와 두 친구. 선택의 여지는 없다. 살고 싶다면 싸워야 한다.",
                            country: "JP",
                            actors: [Actor(name: "박연배", image: "person", role: "iOS Dev")]))
        
        movies.append(Movie(engTitle: "Home Town Cha-Cha-Cha",
                            korTitle: "갯마을 차차차",
                            genre: "로맨스",
                            image: "hometown_cha_cha_cha",
                            rate: 3.9,
                            releaseDate: Date(),
                            story: "현실주의 치과의사 윤혜진과 만능 백수 홍반장이 짠내 사람내음 가득한 바닷마을 '공진'에서 벌이는 티키타카 로맨스를 그린 드라마.",
                            country: "KR",
                            actors: [Actor(name: "박연배", image: "person", role: "iOS Dev")]))
    }
    
    
    //MARK: Objc func
    
    @objc func searchButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard.init(name: "SearchViewStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        vc.movies = self.movies
        
        vc.modalPresentationStyle = .fullScreen
        
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

//MARK: Extension
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
        cell.containerView.layer.shadowRadius = 5
        cell.containerView.layer.cornerRadius = 10
        
        
        cell.posterImage.layer.cornerRadius = 10
        cell.posterImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let movieData = movies[indexPath.row]
        
        cell.posterImage.image = UIImage(named: movieData.image!)
        
        cell.engTitle.text = movieData.engTitle
        cell.engTitle.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    
        cell.korTitle.text = movieData.korTitle
        cell.korTitle.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        cell.genreLabel.text = movieData.genre
        
        let dateString = dateFormatter.string(from: movieData.releaseDate!)
        cell.releaseDate.text = dateString

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UIScreen.main.bounds.height * 0.6
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let sb = UIStoryboard(name: "ActorViewControllerStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ActorViewController") as! ActorViewController
        let actors = movies[indexPath.row].actors
        vc.actors = actors
        self.navigationController?.pushViewController(vc, animated: true)
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
