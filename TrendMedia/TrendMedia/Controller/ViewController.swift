//
//  ViewController.swift
//  TrendMedia
//
//  Created by 박연배 on 2021/10/15.
//

import UIKit

class ViewController: UIViewController {
    
    var movies = [Movie]()
    var filteredMovies = [Movie]() {
        didSet {
            tableView.reloadData()
        }
    }

    //MARK: Property
    lazy var searchButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonClicked(_:)))
        button.tintColor = UIColor.darkGray
        
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
    
    @IBOutlet weak var flimButton: UIButton!
    @IBOutlet weak var dramaButton: UIButton!
    @IBOutlet weak var bookButton: UIButton!
    
    //MARK: Method
    
    func headerStackViewConfig() {
        headerStackView.layer.cornerRadius = 15
        headerStackView.layer.shadowColor = UIColor.black.cgColor
        headerStackView.layer.shadowOpacity = 0.3
        headerStackView.layer.shadowOffset = CGSize.zero
    }
    
    @IBAction func filterButtonClicked(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.filteredMovies = movies.filter({ $0.category! == "영화" })
            print("영화 카테고리")
        case 1:
            self.filteredMovies = movies.filter({ $0.category! == "드라마" })
            print("드라마 카테고리")
        case 2:
            self.filteredMovies = movies.filter({ $0.category! == "서적" })
            print("서적 카테고리")
        default:
            return
        }
    }
    
    func switchButtonImage(_ button: UIButton) {
        for view in headerStackView.subviews {
            if view == button {
                
            }
        }
    }
    
    func fetchMockData() {
        movies.append(Movie(engTitle: "Alice In Borderland",
                            korTitle: "아리스 인 보더랜드",
                            genre: ["생존", "스릴러"],
                            image: "alice_in_borderland",
                            rate: 3.3,
                            releaseDate: Date(),
                            story: "이곳은 또 다른 도쿄, 치명적인 게임의 배경. 그 세계로 세 청년이 던져진다. 무의미한 세월을 보내던 게이머와 두 친구. 선택의 여지는 없다. 살고 싶다면 싸워야 한다.",
                            country: "JP",
                            actors: [Actor(name: "박연배",
                                           image: "person",
                                           role: "iOS Dev"),
                                     Actor(name: "사토 신스케",
                                           image: "person",
                                           role: "감독"),
                                     Actor(name: "야마자키 켄토",
                                           image: "person",
                                           role: "아리스"),
                                     Actor(name: "츠치야 타오",
                                           image: "person",
                                           role: "우사기"),
                                     Actor(name: "마치다 케이타",
                                           image: "person",
                                           role: "가루베"),
                                     Actor(name: "모리나가 유우키",
                                           image: "person",
                                           role: "조타"),
                                     Actor(name: "미사키 아야메",
                                           image: "person",
                                           role: "시부키"),
                                     Actor(name: "카네코 노부야키",
                                           image: "person",
                                           role: "모자장수")],
                           category: "드라마"))
        
        movies.append(Movie(engTitle: "Home Town Cha-Cha-Cha",
                            korTitle: "갯마을 차차차",
                            genre: ["로맨스", "멜로"],
                            image: "hometown_cha_cha_cha",
                            rate: 3.9,
                            releaseDate: Date(),
                            story: "현실주의 치과의사 윤혜진과 만능 백수 홍반장이 짠내 사람내음 가득한 바닷마을 '공진'에서 벌이는 티키타카 로맨스를 그린 드라마.",
                            country: "KR",
                            actors: [Actor(name: "박연배",
                                           image: "person",
                                           role: "iOS Dev"),
                                     Actor(name: "이동규",
                                           image: "person",
                                           role: "제작"),
                                     Actor(name: "유제원",
                                           image: "person",
                                           role: "연출"),
                                     Actor(name: "신민아",
                                           image: "person",
                                           role: "윤혜진"),
                                     Actor(name: "김선호",
                                           image: "person",
                                           role: "홍두식"),
                                     Actor(name: "이상이",
                                           image: "person",
                                           role: "지성현")],
                           category: "드라마"))
        
        movies.append(Movie(engTitle: "Grey's Anatomy",
                            korTitle: "그레이 아나토미",
                            genre: ["의학", "미스테리"],
                            image: "greys_anatomy",
                            rate: 2.8,
                            releaseDate: Date(),
                            story: "주인공 메레디스 그레이와 그녀가 근무하는 병원에서 환자를 살리기 위해 고군분투하는 외과의사들의 열정과 사랑을 다루고 있는 드라마.",
                            country: "US",
                            actors: [Actor(name: "박연배",
                                           image: "person",
                                           role: "iOS Dev"),
                                     Actor(name: "엘런 폼페오",
                                           image: "person",
                                           role: "매러디스 그레이"),
                                     Actor(name: "패트릭 뎀시",
                                           image: "person",
                                           role: "데릭 셰퍼드"),
                                     Actor(name: "제임스 피킨스 주니어",
                                           image: "person",
                                           role: "리처드 웨버"),
                                     Actor(name: "찬드라 윌슨",
                                           image: "person",
                                           role: "미란다 베일리"),
                                     Actor(name: "저스틴 체임버스",
                                           image: "person",
                                           role: "알렉스 카레브")],
                           category: "드라마"))
        
        movies.append(Movie(engTitle: "Squid Game",
                            korTitle: "오징어게임",
                            genre: ["생존", "스릴러"],
                            image: "squid_game",
                            rate: 4.7,
                            releaseDate: Date(),
                            story: "456억 원의 상금이 걸린 의문의 서바이벌에 참가한 사람들이 최후의 승자가 되기 위해 목숨을 걸고 극한의 게임에 도전하는 이야기를 담은 넷플릭스 시리즈. 빚에 쫓기는 수백 명의 사람들이 서바이벌 게임에 뛰어든다. 거액의 상금으로 새로운 삶을 시작하기 위해. 하지만 모두 승자가 될 순 없는 법. 탈락하는 이들은 치명적인 결과를 각오해야 한다.",
                            country: "KR",
                            actors: [Actor(name: "박연배",
                                           image: "person",
                                           role: "iOS Dev"),
                                     Actor(name: "이정재",
                                           image: "person",
                                           role: "성기훈"),
                                     Actor(name: "박해수",
                                           image: "person",
                                           role: "조상우"),
                                     Actor(name: "오영수",
                                           image: "person",
                                           role: "오일남"),
                                     Actor(name: "정호연",
                                           image: "person",
                                           role: "강새벽"),
                                     Actor(name: "허성태",
                                           image: "person",
                                           role: "장덕수")],
                           category: "드라마"))
        
        movies.append(Movie(engTitle: "Avengers: Endgame",
                            korTitle: "어벤져스: 엔드게임",
                            genre: ["액션", "SF"],
                            image: "어벤져스엔드게임",
                            rate: 4.3,
                            releaseDate: Date(),
                            story: "인피니티 워 이후 절반만 살아남은 지구, 마지막 희망이 된 어벤져스. 먼저 떠난 그들을 위해 모든 것을 걸었다! 위대한 어벤져스, 운명을 바꿀 최후의 복수가 펼쳐진다!",
                            country: "US",
                            actors: [Actor(name: "박연배",
                                           image: "person",
                                           role: "iOS Dev"),
                                     Actor(name: "로버트 다우니 주니어",
                                           image: "person",
                                           role: "토니 스타크"),
                                     Actor(name: "크리스 에반스",
                                           image: "person",
                                           role: "스티브 로저스"),
                                     Actor(name: "마크 러팔로",
                                           image: "person",
                                           role: "브루스 배너"),
                                     Actor(name: "크리스 햄스워스",
                                           image: "person",
                                           role: "토르"),
                                     Actor(name: "스칼렛 요한슨",
                                           image: "person",
                                           role: "블랙 위도우")],
                           category: "영화"))
        
        movies.append(Movie(engTitle: "Masquerade",
                            korTitle: "광해, 왕이 된 남자",
                            genre: ["사극", "SF"],
                            image: "광해",
                            rate: 4.3,
                            releaseDate: Date(),
                            story: "왕위를 둘러싼 권력 다툼과 당쟁으로 혼란이 극에 달한 광해군 8년. 자신의 목숨을 노리는 자들에 대한 분노와 두려움으로 점점 난폭해져 가던 왕 ‘광해’는 도승지 ‘허균’에게 자신을 대신하여 위협에 노출될 대역을 찾을 것을 지시한다. 이에 허균은 기방의 취객들 사이에 걸쭉한 만담으로 인기를 끌던 하선을 발견한다. 왕과 똑같은 외모는 물론 타고난 재주와 말솜씨로 왕의 흉내도 완벽하게 내는 하선. 영문도 모른 채 궁에 끌려간 하선은 광해군이 자리를 비운 하룻밤 가슴 조이며 왕의 대역을 하게 된다.",
                            country: "KR",
                            actors: [Actor(name: "박연배",
                                           image: "person",
                                           role: "iOS Dev"),
                                     Actor(name: "이병헌",
                                           image: "person",
                                           role: "광해군/하선"),
                                     Actor(name: "류승룡",
                                           image: "person",
                                           role: "허균"),
                                     Actor(name: "한효주",
                                           image: "person",
                                           role: "중전"),
                                     Actor(name: "장광",
                                           image: "person",
                                           role: "조 내관"),
                                     Actor(name: "김인권",
                                           image: "person",
                                           role: "도부장")],
                           category: "영화"))
        
        movies.append(Movie(engTitle: "A Tale Dark and Grimm",
                            korTitle: "어 테일 다크 앤드 그림",
                            genre: ["판타지", "키즈"],
                            image: "a_tale_dark_grimm",
                            rate: 4.3,
                            releaseDate: Date(),
                            story: "헨젤과 그레텔이 그들 자신의 이야기에서 벗어나 기이하고 무서운 놀라움으로 가득 찬 구불구불하고 사악하게 재치 있는 이야기 속으로 걸어가는 과정을 따라가십시오.",
                            country: "DE",
                            actors: [Actor(name: "박연배",
                                           image: "person",
                                           role: "iOS Dev"),
                                     Actor(name: "애덤 기드워츠",
                                           image: "person",
                                           role: "작가"),
                                     Actor(name: "핸젤",
                                           image: "person",
                                           role: "핸젤"),
                                     Actor(name: "그레텔",
                                           image: "person",
                                           role: "그레텔"),
                                     Actor(name: "요하네스",
                                           image: "person",
                                           role: "요하네스"),
                                     Actor(name: "도티",
                                           image: "person",
                                           role: "도티")],
                           category: "서적"))
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
        
        return filteredMovies.isEmpty ? movies.count : filteredMovies.count
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
        
        var movieData = movies[indexPath.row]
        
        if !filteredMovies.isEmpty {
            movieData = filteredMovies[indexPath.row]
        }
        
        
        cell.posterImage.image = UIImage(named: movieData.image!)
        
        cell.engTitle.text = movieData.engTitle
        cell.engTitle.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    
        cell.korTitle.text = movieData.korTitle
        cell.korTitle.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        
        cell.genreLabel.text = ""
        for genre in movieData.genre {
            cell.genreLabel.text! += "#" + genre + " "
        }
        
        let dateString = dateFormatter.string(from: movieData.releaseDate!)
        cell.releaseDate.text = dateString

        cell.ratingLabel.text = String(movieData.rate!)
        
        
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
