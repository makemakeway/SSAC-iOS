//
//  ViewController.swift
//  SSACMovie
//
//  Created by 박연배 on 2021/09/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: Properties
    lazy var mainPoster: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var logo: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var background: UIImage!
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play_normal"), for: .normal)
        button.setImage(UIImage(named: "play_highlighted"), for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(setPoster(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "info"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "check"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var footerHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insetsLayoutMarginsFromSafeArea = false
        return stackView
    }()
    
    lazy var footerVStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insetsLayoutMarginsFromSafeArea = false
        return stackView
    }()
    
    //MARK: Functions
    
    func setPoster() {
        print("setposter")
        self.mainPoster.image = UIImage(named: "poster\(Int.random(in: 1...10))")
    }
    
    
    func mainPosterConfig() {
        self.view.addSubview(mainPoster)
        self.mainPoster.contentMode = .scaleToFill
        self.mainPoster.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.height * 0.75)
            make.top.equalTo(view.snp.top)
        }
    }
    func logoConfig() {
        self.mainPoster.addSubview(logo)
        self.logo.text = "N"
        self.logo.font = UIFont.boldSystemFont(ofSize: 58)
        self.logo.textColor = .systemRed
        self.mainPoster.addSubview(self.logo)
        self.logo.snp.makeConstraints { make in
            make.top.equalTo(mainPoster.snp.top).offset(20)
            make.leading.equalTo(mainPoster.snp.leading).offset(20)
        }
    }
    func headerStackConfig() {
        let firstLabel = UILabel()
        let secondLabel = UILabel()
        let thirdLabel = UILabel()
        
        
        firstLabel.text = "TV프로그램"
        secondLabel.text = "영화"
        thirdLabel.text = "내가 찜한 콘텐츠"
        
        firstLabel.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .semibold)
        secondLabel.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .semibold)
        thirdLabel.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .semibold)
        
        firstLabel.textColor = .white
        secondLabel.textColor = .white
        thirdLabel.textColor = .white
        
        firstLabel.adjustsFontSizeToFitWidth = true
        secondLabel.adjustsFontSizeToFitWidth = true
        thirdLabel.adjustsFontSizeToFitWidth = true
        
        mainPoster.addSubview(hStack)
        hStack.addArrangedSubview(firstLabel)
        hStack.addArrangedSubview(secondLabel)
        hStack.addArrangedSubview(thirdLabel)
        
        hStack.snp.makeConstraints { make in
            make.centerY.equalTo(logo.snp.centerY)
            make.trailing.equalTo(mainPoster.snp.trailing).offset(-20)
        }
    }
    func footherStackConfig() {
        mainPoster.addSubview(footerHStack)
        
        footerHStack.snp.makeConstraints { make in
            make.bottom.equalTo(mainPoster.snp.bottom)
            make.leading.equalTo(mainPoster.snp.leading)
            make.trailing.equalTo(mainPoster.snp.trailing)
        }
    }
    
    func firstFooterConfig() {
        let firstVstack = UIStackView()
        firstVstack.axis = .vertical
        firstVstack.distribution = .fill
        firstVstack.alignment = .fill
        firstVstack.translatesAutoresizingMaskIntoConstraints = false
        firstVstack.insetsLayoutMarginsFromSafeArea = false
        let firstLabel = UILabel()
        firstLabel.text = "내가 찜한 콘텐츠"
        firstLabel.textColor = .white
        firstLabel.textAlignment = .center
        firstLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        firstVstack.addArrangedSubview(self.checkButton)
        firstVstack.addArrangedSubview(firstLabel)
        footerHStack.addArrangedSubview(firstVstack)
    }
    
    func secondFooterConfig() {
        let secondVstack = UIStackView()
        secondVstack.axis = .vertical
        secondVstack.distribution = .fill
        secondVstack.alignment = .fill
        secondVstack.translatesAutoresizingMaskIntoConstraints = false
        secondVstack.insetsLayoutMarginsFromSafeArea = false
        secondVstack.addArrangedSubview(self.playButton)
        footerHStack.addArrangedSubview(secondVstack)
    }
    
    func thirdFooterConfig() {
        let thirdVstack = UIStackView()
        thirdVstack.axis = .vertical
        thirdVstack.distribution = .fill
        thirdVstack.alignment = .fill
        thirdVstack.translatesAutoresizingMaskIntoConstraints = false
        thirdVstack.insetsLayoutMarginsFromSafeArea = false
        let thirdLabel = UILabel()
        thirdLabel.text = "정보"
        thirdLabel.textColor = .white
        thirdLabel.textAlignment = .center
        thirdLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        thirdVstack.addArrangedSubview(self.infoButton)
        thirdVstack.addArrangedSubview(thirdLabel)
        footerHStack.addArrangedSubview(thirdVstack)
    }
    
    func backgroundConfig() {
        background = UIImage(named: "background")
    }
    
    //MARK: objc functions
    
    @objc func setPoster(_ button: UIButton) {
        setPoster()
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        view.contentMode = .scaleToFill
        mainPosterConfig()
        setPoster()
        logoConfig()
        headerStackConfig()
        footherStackConfig()
        firstFooterConfig()
        secondFooterConfig()
        thirdFooterConfig()
    }
    
}
