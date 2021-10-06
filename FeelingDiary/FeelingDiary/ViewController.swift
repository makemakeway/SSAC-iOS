//
//  ViewController.swift
//  FeelingDiary
//
//  Created by 박연배 on 2021/10/06.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    //MARK: Property
    
    lazy var sideButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(sideMenuClicked(_:)))
        
        return button
    }()
    
    lazy var vStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var firstButtonTitle: UILabel = {
        let label = makeCountLabel(title: "행복해", for: 0)
        return label
    }()
    lazy var secondButtonTitle: UILabel = {
        let label = makeCountLabel(title: "사랑해", for: 1)
        return label
    }()
    lazy var thirdButtonTitle: UILabel = {
        let label = makeCountLabel(title: "좋아해", for: 2)
        return label
    }()
    lazy var fourthButtonTitle: UILabel = {
        let label = makeCountLabel(title: "당황해", for: 3)
        return label
    }()
    lazy var fifthButtonTitle: UILabel = {
        let label = makeCountLabel(title: "속상해", for: 4)
        return label
    }()
    lazy var sixthButtonTitle: UILabel = {
        let label = makeCountLabel(title: "우울해", for: 5)
        return label
    }()
    lazy var seventhButtonTitle: UILabel = {
        let label = makeCountLabel(title: "심심해", for: 6)
        return label
    }()
    lazy var eighthButtonTitle: UILabel = {
        let label = makeCountLabel(title: "지루해", for: 7)
        return label
    }()
    lazy var ninethButtonTitle: UILabel = {
        let label = makeCountLabel(title: "상쾌해", for: 8)
        return label
    }()
    
    //MARK: Method
    
    func vStackConfig() {
        view.addSubview(vStack)
        let firstHstack = makeHstack()
        let secondHstack = makeHstack()
        let thirdHstack = makeHstack()
        
        firstHstack.addArrangedSubview(makeCell(title: "행복해",
                                                image: UIImage(named: "mono_slime1")!,
                                                buttonTag: 0))
        firstHstack.addArrangedSubview(makeCell(title: "사랑해",
                                                image: UIImage(named: "mono_slime2")!,
                                                buttonTag: 1))
        firstHstack.addArrangedSubview(makeCell(title: "좋아해",
                                                image: UIImage(named: "mono_slime3")!,
                                                buttonTag: 2))
        
        secondHstack.addArrangedSubview(makeCell(title: "당황해",
                                                 image: UIImage(named: "mono_slime4")!,
                                                 buttonTag: 3))
        secondHstack.addArrangedSubview(makeCell(title: "속상해",
                                                 image: UIImage(named: "mono_slime5")!,
                                                 buttonTag: 4))
        secondHstack.addArrangedSubview(makeCell(title: "우울해",
                                                 image: UIImage(named: "mono_slime6")!,
                                                 buttonTag: 5))
        
        thirdHstack.addArrangedSubview(makeCell(title: "심심해",
                                                 image: UIImage(named: "mono_slime7")!,
                                                buttonTag: 6))
        thirdHstack.addArrangedSubview(makeCell(title: "지루해",
                                                 image: UIImage(named: "mono_slime8")!,
                                                buttonTag: 7))
        thirdHstack.addArrangedSubview(makeCell(title: "상쾌해",
                                                 image: UIImage(named: "mono_slime9")!,
                                                buttonTag: 8))
        
        vStack.addArrangedSubview(firstHstack)
        vStack.addArrangedSubview(secondHstack)
        vStack.addArrangedSubview(thirdHstack)
        
        vStack.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
    }
    
    func makeHstack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 20
        return stack
    }
    
    func makeCell(title: String, image: UIImage, buttonTag: Int) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(feelingButtonClicked(_:)), for: .touchUpInside)
        button.tag = buttonTag
        
        button.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        
        stack.addArrangedSubview(button)
        stack.addArrangedSubview(makeCountLabel(title: title, for: button.tag))
        return stack
    }
    
    func makeCountLabel(title: String, for key: Int) -> UILabel {
        let label = UILabel()
        label.text = title + " \(UserDefaults.standard.integer(forKey: "\(key)"))"
        label.textAlignment = .center
        
        return label
    }
    
    func updateLabel() {
        
    }
    
    //MARK: objc function
    @objc func feelingButtonClicked(_ sender: UIButton) {
        let count = UserDefaults.standard.integer(forKey: "\(sender.tag)")
        UserDefaults.standard.set(count + 1, forKey: "\(sender.tag)")
    }
    
    @objc func sideMenuClicked(_ sender: UIButton) {
        print("side menu")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        self.navigationItem.title = "감정 다이어리"
        self.navigationItem.leftBarButtonItem = sideButton
        vStackConfig()
        
    }


}
