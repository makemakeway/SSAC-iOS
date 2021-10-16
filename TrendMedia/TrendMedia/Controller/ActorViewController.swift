//
//  ActorViewController.swift
//  TrendMedia
//
//  Created by 박연배 on 2021/10/16.
//

import UIKit

class ActorViewController: UIViewController {

    
    
    //MARK: Property
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var actors: [Actor] = [Actor]()
    
    lazy var backButtonCustomView: UIButton = {
        
        var configure = UIButton.Configuration.plain()
        configure.title = "뒤로"
        configure.image = UIImage(systemName: "chevron.left")
        configure.imagePadding = 5
        configure.titleAlignment = .center
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
    
    
    @objc func backButtonClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "출연/제작"
        self.view.backgroundColor = .systemGray
        self.navigationItem.leftBarButtonItem = backButton
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
}

extension ActorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActorTableViewCell", for: indexPath) as? ActorTableViewCell else {
            return UITableViewCell()
        }
        
        let data = actors[indexPath.row]
        
        cell.name.text = data.name!
        cell.name.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        cell.role.text = data.role!
        cell.role.font = UIFont.systemFont(ofSize: 14)
        cell.role.textColor = .gray
        
        cell.profileImage.image = UIImage(systemName: data.image!)
        cell.profileImage.backgroundColor = .label
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.15
    }
    
}
