//
//  SecondViewController.swift
//  SSACfood
//
//  Created by 박연배 on 2021/09/29.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {

    //MARK: Property
    lazy var headerHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insetsLayoutMarginsFromSafeArea = false
        return stackView
    }()
    
    
    //MARK: Method
    func makeHeaderButton(title: String) -> UIButton{
        let button = UIButton()
        let attrs = [NSAttributedString.Key.foregroundColor : UIColor.systemBlue,
                     NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]
        let attributed = NSMutableAttributedString(string: title, attributes: attrs)
        
        button.setAttributedTitle(attributed, for: .normal)
        button.addTarget(self, action: #selector(headerButtonClicked(_:)), for: .touchUpInside)
        return button
    }
    
    func headerHstackConfig() {
        view.addSubview(headerHStack)
        headerHStack.addArrangedSubview(makeHeaderButton(title: "찜한가게"))
        headerHStack.addArrangedSubview(makeHeaderButton(title: "바로결제"))
        headerHStack.addArrangedSubview(makeHeaderButton(title: "전화주문"))
        
        
        headerHStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading).offset(40)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
        }
    }
    //MARK: Objc Func
    @objc func headerButtonClicked(_ sender: UIButton) {
        print(sender.titleLabel!.text!)
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        headerHstackConfig()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "찜한가게"
        self.view.backgroundColor = .white
    }
    
    
}
