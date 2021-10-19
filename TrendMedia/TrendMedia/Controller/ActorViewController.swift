//
//  ActorViewController.swift
//  TrendMedia
//
//  Created by 박연배 on 2021/10/16.
//

import UIKit
import Kingfisher
import MapKit

class ActorViewController: UIViewController {

    
    
    //MARK: Property
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var movieBackgroundImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var opacityView: UIView!
    
    var movieInfo: Movie?
    
    var spreaded: Bool = false
    
    lazy var backButtonCustomView: UIButton = {
        
        var configure = UIButton.Configuration.plain()
        configure.title = "뒤로"
        configure.image = UIImage(systemName: "chevron.left")
        configure.imagePadding = 5
        configure.baseForegroundColor = .label
        
        let button = UIButton(configuration: configure, primaryAction: nil)
        button.addTarget(self, action: #selector(backButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(customView: backButtonCustomView)
        return button
    }()
    
    
    //MARK: Method
    
    func fetchHeaderView() {
        guard let urlString = movieInfo?.imageURL else {
            print("movieInfo에 URL이 없습니다.")
            return
        }
        guard let url = URL(string: urlString) else {
            print("URL 변환 실패")
            return
        }
        guard let data = movieInfo else {
            print("movie data missing")
            return
        }

        
        movieBackgroundImageView.kf.setImage(with: url) { _ in
            self.movieTitle.text = data.engTitle!
            self.posterImageView.image = UIImage(named: data.image!)
        }
        
    }
    
    func headerOpacityConfig() {
        opacityView.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
    }
    
    @objc func backButtonClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "출연/제작"
        self.navigationItem.leftBarButtonItem = backButton
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        let nib = UINib(nibName: StoryTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: StoryTableViewCell.identifier)
        
        
        fetchHeaderView()
        movieTitle.textColor = .white
        movieBackgroundImageView.contentMode = .scaleAspectFill
        headerOpacityConfig()
    }
    
}


//MARK: TableView Delegate
extension ActorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
        guard let data = movieInfo?.actors else { return 0 }
        return data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 섹션이 0일 때
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.identifier, for: indexPath) as? StoryTableViewCell else { return UITableViewCell() }
            cell.storyLabel.text = movieInfo?.story!
            cell.delegate = self
            let image = spreaded == true ? "chevron.up" : "chevron.down"
            cell.spreadButton.setImage(UIImage(systemName: image), for: .normal)
            return cell
        }
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActorTableViewCell", for: indexPath) as? ActorTableViewCell else {
            return UITableViewCell()
        }
        
        guard let data = movieInfo?.actors[indexPath.row] else { return UITableViewCell() }
        
        
        cell.name.text = data.name!
        cell.name.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        cell.role.text = data.role!
        cell.role.font = UIFont.systemFont(ofSize: 14)
        cell.role.textColor = .gray
        
        cell.profileImage.image = UIImage(systemName: data.image!)
        cell.profileImage.backgroundColor = .label
        cell.profileImage.layer.cornerRadius = 10
        
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 원하는 것이 줄거리 섹션의 높이를 조절하는 것이기 때문에 조건을 제한
        if indexPath.section == 0 && spreaded {
            return UITableView.automaticDimension
        }
        
        return UIScreen.main.bounds.height * 0.125
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        print(indexPath)
        return nil
    }
    
}


extension ActorViewController: SpreadButtonDelegate {
    func spreadAndFold() {
        spreaded.toggle()
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
}
