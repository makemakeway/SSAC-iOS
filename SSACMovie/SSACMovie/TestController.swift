//
//  TestController.swift
//  SSACMovie
//
//  Created by 박연배 on 2021/09/29.
//

import UIKit

class TestController: UIViewController {

    lazy var background: UIImageView = {
        let image = UIImageView(image: UIImage(named: "background"))
        
        
        return image
    }()

    lazy var mainScrollView: UIScrollView = {
        let scv = UIScrollView()
        scv.translatesAutoresizingMaskIntoConstraints = false
        scv.alwaysBounceVertical = true
        scv.insetsLayoutMarginsFromSafeArea = false
        
        return scv
    }()
    
    lazy var vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insetsLayoutMarginsFromSafeArea = false
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var manualLabel: UILabel = {
        let label = UILabel()
        label.text = "긴장감 넘치는 ・ 스릴러 ・ 드라마 장르"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var posters = [UIImageView(image: UIImage(named: "7번방의선물")),
                   UIImageView(image: UIImage(named: "광해")),
                   UIImageView(image: UIImage(named: "겨울왕국")),
                   UIImageView(image: UIImage(named: "괴물")),
                   UIImageView(image: UIImage(named: "국제시장")),
                   UIImageView(image: UIImage(named: "극한직업")),
                   UIImageView(image: UIImage(named: "도둑들")),
                   UIImageView(image: UIImage(named: "명량")),
                   UIImageView(image: UIImage(named: "베테랑")),
                   UIImageView(image: UIImage(named: "부산행")),
                   UIImageView(image: UIImage(named: "신과함께인과연")),
                   UIImageView(image: UIImage(named: "신과함께죄와벌")),
                   UIImageView(image: UIImage(named: "아바타")),
                   UIImageView(image: UIImage(named: "알라딘")),
                   UIImageView(image: UIImage(named: "암살"))
    ]
    
    lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insetsLayoutMarginsFromSafeArea = false
        return stackView
    }()
    
    lazy var playButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "play_normal"), for: .normal)
        button.setImage(UIImage(named: "play_highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(setPoster(_:)), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: Functions
    @objc func setPoster(_ button: UIButton) {
        print("setposter")
    }
    
    func backgroundConfig() {
        view.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func mainScrollConfig() {
        background.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(background)
        }
    }
    
    func vstackConfig() {
        mainScrollView.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.edges.equalTo(mainScrollView)
        }
    }
    
    func choosePoster() -> UIImageView {
        let poster: UIImageView
        poster = posters[Int.random(in: 0...13)]
        return poster
    }
    
    func posterConfig() {
        let poster = choosePoster()
        poster.translatesAutoresizingMaskIntoConstraints = false
        vStack.addArrangedSubview(poster)
        poster.snp.makeConstraints { make in
            make.top.equalTo(mainScrollView)
            make.width.equalTo(view.frame.size.width)
            make.height.equalTo(view.frame.size.height * 0.5)
        }
    }
    
    func manualLabelConfig() {
        vStack.addArrangedSubview(manualLabel)
        manualLabel.snp.makeConstraints { make in
            
        }
    }
    
    func hstackConfig() {
//        vStack.addArrangedSubview(hStack)
//        hStack.spacing = 10
    }
    
    func addButtons() {
        vStack.addArrangedSubview(playButton)
    }
    
    func addPosters() {
        for poster in posters {
            hStack.addArrangedSubview(poster)
        }
        
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insetsLayoutMarginsFromSafeArea = false
        backgroundConfig()
        mainScrollConfig()
        vstackConfig()
        posterConfig()
        manualLabelConfig()
        hstackConfig()
        addButtons()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }


}
