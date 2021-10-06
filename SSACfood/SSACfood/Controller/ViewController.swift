//
//  ViewController.swift
//  SSACfood
//
//  Created by 박연배 on 2021/09/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    //MARK: Property
    
    lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var vStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var searchTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "먹고 싶은 메뉴, 가게 검색"
        
        return field
    }()
    
    //MARK: Method
    func textFieldConfig() {
        view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(vStack.snp.bottom).offset(40)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
    }
    
    private func stackConfig() {
        self.view.addSubview(vStack)
        let firstHstack = makeHStack()
        let secondHstack = makeHStack()
        let thirdHstack = makeHStack()
        
        self.vStack.addArrangedSubview(firstHstack)
        
        firstHstack.addArrangedSubview(makeCell(button: makeButton(imageTitle: "mono_baedal01"), title: "배민라이더스"))
        firstHstack.addArrangedSubview(makeCell(button: makeButton(imageTitle: "mono_baedal02"), title: "2인분"))
        firstHstack.addArrangedSubview(makeCell(button: makeButton(imageTitle: "mono_baedal04"), title: "한식"))
        
        self.vStack.addArrangedSubview(secondHstack)
        
        secondHstack.addArrangedSubview(makeCell(button: makeButton(imageTitle: "mono_baedal07"), title: "돈까스・회・일식"))
        secondHstack.addArrangedSubview(makeCell(button: makeButton(imageTitle: "mono_baedal08"), title: "치킨"))
        secondHstack.addArrangedSubview(makeCell(button: makeButton(imageTitle: "mono_baedal05"), title: "분식"))
        
        self.vStack.addArrangedSubview(thirdHstack)
        
        thirdHstack.addArrangedSubview(makeCell(button: makeButton(imageTitle: "mono_baedal12"), title: "족발・보쌈"))
        thirdHstack.addArrangedSubview(makeCell(button: makeButton(imageTitle: "mono_baedal09"), title: "피자"))
        thirdHstack.addArrangedSubview(makeCell(button: makeButton(imageTitle: "mono_baedal11"), title: "중국집"))
        
        vStack.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(view.snp.top).offset(200)
            make.bottom.equalTo(view.snp.bottom).offset(-300)
        }
    }
    
    private func makeButton(imageTitle: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "\(imageTitle)"), for: .normal)
        button.setBackgroundImage(UIImage(named: "menu_bg"), for: .normal)
        
        
        button.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        return button
    }
    
    private func makeHStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }
    
    private func makeCell(button: UIButton, title: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(label)
        return stackView
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let background = UIImageView()
        background.frame = view.frame
        background.image = UIImage(named: "menu_bg")
        view.addSubview(background)
        
        self.view.backgroundColor = .systemTeal
        stackConfig()
        textFieldConfig()
        
        let gesture = UITapGestureRecognizer()
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
    }
}

//MARK: Extension

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
