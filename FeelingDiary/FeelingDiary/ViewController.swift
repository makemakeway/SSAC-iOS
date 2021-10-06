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
        button.tintColor = .black
        
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
        let label = UILabel()
        label.textAlignment = .center
        label.tag = 0
        return label
    }()
    lazy var secondButtonTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tag = 1
        return label
    }()
    lazy var thirdButtonTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tag = 2
        return label
    }()
    lazy var fourthButtonTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tag = 3
        return label
    }()
    lazy var fifthButtonTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tag = 4
        return label
    }()
    lazy var sixthButtonTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tag = 5
        return label
    }()
    lazy var seventhButtonTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tag = 6
        return label
    }()
    lazy var eighthButtonTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tag = 7
        return label
    }()
    lazy var ninethButtonTitle: UILabel = {
        let label = UILabel()
        label.text = "행복해" + " \(UserDefaults.standard.integer(forKey: "8"))"
        label.textAlignment = .center
        label.tag = 8
        return label
    }()
    
    //MARK: Method
    
    func vStackConfig() {
        view.addSubview(vStack)
        let firstHstack = makeHstack()
        let secondHstack = makeHstack()
        let thirdHstack = makeHstack()
        
        vStack.addArrangedSubview(firstHstack)
        
        firstHstack.addArrangedSubview(makeCell(label: firstButtonTitle,
                                                image: UIImage(named: "mono_slime1")!,
                                                tag: 0))
        firstHstack.addArrangedSubview(makeCell(label: secondButtonTitle,
                                                image: UIImage(named: "mono_slime2")!,
                                                tag: 1))
        firstHstack.addArrangedSubview(makeCell(label: thirdButtonTitle,
                                                image: UIImage(named: "mono_slime3")!,
                                                tag: 2))
        
        vStack.addArrangedSubview(secondHstack)
        
        secondHstack.addArrangedSubview(makeCell(label: fourthButtonTitle,
                                                image: UIImage(named: "mono_slime4")!,
                                                tag: 3))
        secondHstack.addArrangedSubview(makeCell(label: fifthButtonTitle,
                                                image: UIImage(named: "mono_slime5")!,
                                                tag: 4))
        secondHstack.addArrangedSubview(makeCell(label: sixthButtonTitle,
                                                image: UIImage(named: "mono_slime6")!,
                                                tag: 5))
        
        vStack.addArrangedSubview(thirdHstack)
        
        thirdHstack.addArrangedSubview(makeCell(label: seventhButtonTitle,
                                                image: UIImage(named: "mono_slime7")!,
                                                tag: 6))
        thirdHstack.addArrangedSubview(makeCell(label: eighthButtonTitle,
                                                image: UIImage(named: "mono_slime8")!,
                                                tag: 7))
        thirdHstack.addArrangedSubview(makeCell(label: ninethButtonTitle,
                                                image: UIImage(named: "mono_slime9")!,
                                                tag: 8))
        
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
    
    func makeCell(label: UILabel, image: UIImage, tag: Int) -> UIStackView {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tag = tag
        button.addTarget(self, action: #selector(feelingButtonClicked(_:)), for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        
        stack.addArrangedSubview(button)
        stack.addArrangedSubview(label)
        return stack
    }
    
    func labelReload() {
        self.firstButtonTitle.text = "행복해 \(UserDefaults.standard.integer(forKey: "\(firstButtonTitle.tag)"))"
        self.secondButtonTitle.text = "사랑해 \(UserDefaults.standard.integer(forKey: "\(secondButtonTitle.tag)"))"
        self.thirdButtonTitle.text = "좋아해 \(UserDefaults.standard.integer(forKey: "\(thirdButtonTitle.tag)"))"
        self.fourthButtonTitle.text = "당황해 \(UserDefaults.standard.integer(forKey: "\(fourthButtonTitle.tag)"))"
        self.fifthButtonTitle.text = "속상해 \(UserDefaults.standard.integer(forKey: "\(fifthButtonTitle.tag)"))"
        self.sixthButtonTitle.text = "우울해 \(UserDefaults.standard.integer(forKey: "\(sixthButtonTitle.tag)"))"
        self.seventhButtonTitle.text = "심심해 \(UserDefaults.standard.integer(forKey: "\(seventhButtonTitle.tag)"))"
        self.eighthButtonTitle.text = "행복해 \(UserDefaults.standard.integer(forKey: "\(eighthButtonTitle.tag)"))"
        self.ninethButtonTitle.text = "행복해 \(UserDefaults.standard.integer(forKey: "\(ninethButtonTitle.tag)"))"
    }
    
    //MARK: objc function
    @objc func feelingButtonClicked(_ sender: UIButton) {
        let count = UserDefaults.standard.integer(forKey: "\(sender.tag)")
        UserDefaults.standard.set(count + 1, forKey: "\(sender.tag)")
        UserDefaults.standard.synchronize()
        labelReload()
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
        labelReload()
    }


}
