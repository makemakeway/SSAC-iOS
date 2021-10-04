//
//  ViewController.swift
//  NewlySearchApp
//
//  Created by 박연배 on 2021/10/02.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: User Defined Property
    var newlyWords: [String:String] = [:]
    var randomNumbers = [Int]()
    
    
    
    //MARK: Subview Properties
    lazy var indicatior: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.center = view.center
        let transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
        indicator.transform = transform
        
        return indicator
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    lazy var backgroundView: UIImageView = {
        let background = UIImageView()
        background.image = UIImage(named: "background")
        background.contentMode = .scaleAspectFit
        return background
    }()
    
    lazy var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.layer.borderWidth = 2
        return stackView
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(searchButtonClicked(_:)), for: .touchUpInside)
        button.isMultipleTouchEnabled = false
        return button
    }()
    
    lazy var emptyView : UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.frame = self.view.frame
        return view
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "신조어를 입력해주세요."
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.tintColor = .black
        return textField
    }()
    
    lazy var firstButton: UIButton = {
        return makeHashTagButton()
    }()
    
    lazy var secondButton: UIButton = {
        return makeHashTagButton()
    }()
    
    lazy var thirdButton: UIButton = {
        return makeHashTagButton()
    }()
    
    lazy var fourthButton: UIButton = {
        return makeHashTagButton()
    }()
    
    
    
    //MARK: User Defined Methods
    func makeHashTagButton() -> UIButton {
        let configure = UIButton.Configuration.plain()
        let button = UIButton(configuration: configure, primaryAction: nil)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.backgroundColor = .white
        button.setTitleColor(.gray, for: .highlighted)
        button.addTarget(self, action: #selector(hashTagClicked(_:)), for: .touchUpInside)
        button.isMultipleTouchEnabled = false
        return button
    }
    
    
    // 해시태그 버튼 타이틀을 랜덤으로 설정하는 메소드
    func selectHashTagsTitle() {
        let keys = newlyWords.keys.shuffled()
        var selectedkeys = [String]()
        while selectedkeys.count != 4 {
            for key in keys {
                if !selectedkeys.contains(key) {
                    selectedkeys.append(key)
                    break
                }
            }
        }
        firstButton.setTitle(selectedkeys[0], for: .normal)
        secondButton.setTitle(selectedkeys[1], for: .normal)
        thirdButton.setTitle(selectedkeys[2], for: .normal)
        fourthButton.setTitle(selectedkeys[3], for: .normal)
    }
    
    // 신조어를 딕셔너리 형태로 저장하는 메소드
    func addNewlyWord(key: String, value: String) {
        newlyWords[key] = value
    }
    
    // 텍스트필드가 비어있는지 확인하는 메소드
    func checkSearchTextField() -> Bool {
        if searchTextField.text!.isEmpty {
            let alert = UIAlertController(title: "", message: "검색하고 싶은 신조어를 입력해주세요.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    
    // 버튼들을 비활성화 하는 메소드
    func disableButtons() {
        for views in self.containerView.subviews {
            if let button = views as? UIButton {
                button.isEnabled = false
            }
        }
        searchButton.isEnabled = false
    }
    
    // 버튼들을 활성화 하는 메소드
    func enableButtons() {
        for views in self.containerView.subviews {
            if let button = views as? UIButton {
                button.isEnabled = true
            }
        }
        searchButton.isEnabled = true
    }
    
    
    //MARK: Subview Configurations
    func valueLabelConfig() {
        view.addSubview(valueLabel)
        
        valueLabel.snp.makeConstraints { make in
            make.center.equalTo(view.center)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
        }
    }
    
    func searchStackViewConfig() {
        containerView.addSubview(searchStackView)
        searchStackView.addArrangedSubview(emptyView)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(searchButton)
        
        emptyView.snp.makeConstraints { make in
            make.width.equalTo(15)
        }
        
        searchButton.snp.makeConstraints { make in
            make.width.equalTo(searchButton.snp.height)
        }
        
        
        searchStackView.snp.makeConstraints({ make in
            make.top.equalTo(view.snp.top).offset(40)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
            make.height.equalTo(40)
        })
    }
    
    func hashTagButtonsConfig(){
        containerView.addSubview(firstButton)
        containerView.addSubview(secondButton)
        containerView.addSubview(thirdButton)
        containerView.addSubview(fourthButton)
        
        
        firstButton.snp.makeConstraints { make in
            make.top.equalTo(searchStackView.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(15)
        }
        secondButton.snp.makeConstraints { make in
            make.top.equalTo(searchStackView.snp.bottom).offset(10)
            make.leading.equalTo(firstButton.snp.trailing).offset(5)
        }
        thirdButton.snp.makeConstraints { make in
            make.top.equalTo(searchStackView.snp.bottom).offset(10)
            make.leading.equalTo(secondButton.snp.trailing).offset(5)
        }
        fourthButton.snp.makeConstraints { make in
            make.top.equalTo(searchStackView.snp.bottom).offset(10)
            make.leading.equalTo(thirdButton.snp.trailing).offset(5)
        }
    }
    
    
    
    //MARK: objc func
    
    // 해시태그를 터치했을 때 호출되는 메소드
    @objc func hashTagClicked(_ sender: UIButton) {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                sender.isUserInteractionEnabled = false
                self.view.addSubview(self.indicatior)
                self.indicatior.startAnimating()
                self.disableButtons()
            }
            // Request를 처리하는 과정
            sleep(3)
            
            // Request를 처리하고 결과를 받아올 때
            DispatchQueue.main.async {
                self.selectHashTagsTitle()
                self.valueLabel.text = self.newlyWords[sender.titleLabel?.text ?? ""]
                sender.isUserInteractionEnabled = true
                self.indicatior.stopAnimating()
                self.indicatior.removeFromSuperview()
                self.enableButtons()
            }
        }
        print("누른 버튼은 \(sender.titleLabel!.text!) 입니다.")
    }
    
    
    // 서치바에 있는 버튼을 터치했을 때 호출되는 메소드
    @objc func searchButtonClicked(_ sender: UIButton) {
        if self.textFieldShouldReturn(self.searchTextField) {
            print("search Button을 통한 검색")
        }
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        view.addSubview(backgroundView)
        backgroundView.frame = view.frame
        view.addSubview(containerView)
    
        let gesture = UITapGestureRecognizer()
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        
        
        addNewlyWord(key: "jmt", value: "존맛탱")
        addNewlyWord(key: "별다줄", value: "별걸 다 줄인다")
        addNewlyWord(key: "복세편살", value: "복잡한 세상 편하게 살자")
        addNewlyWord(key: "낄끼빠빠", value: "낄때는 끼고 빠질때는 빠져라")
        addNewlyWord(key: "갑분싸", value: "갑자기 분위기가 싸해지다")
        addNewlyWord(key: "내로남불", value: "내가 하면 로맨스, 남이 하면 불륜")
        addNewlyWord(key: "문찐", value: "문화 찐따. 유행에 느린 사람을 의미")
        addNewlyWord(key: "삼귀자", value: "사귀자의 전 단계")
        addNewlyWord(key: "일코", value: "일반인 코스프레")
        addNewlyWord(key: "ㅈㄱㄴ", value: "제목이 곧 내용")
        searchStackViewConfig()
        selectHashTagsTitle()
        hashTagButtonsConfig()
        valueLabelConfig()
    }

    

}

//MARK: Extension
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 텍스트필드가 비어있는지 확인 후, 비어있다면 메소드 종료
        if !checkSearchTextField() {
            print("텍스트 필드가 비어있습니다.")
            return false
        }
        // 비어있지 않다면, 텍스트에 대한 검색을 진행
        DispatchQueue.global().async {
            
            // User에게 검색이 진행되고 있다는 것을 알려주는 UX작성
            DispatchQueue.main.async {
                self.view.addSubview(self.indicatior)
                self.indicatior.startAnimating()
                self.disableButtons()
            }
            sleep(3)
            // Request를 처리하고 결과를 받아올 때
            DispatchQueue.main.async {
                self.selectHashTagsTitle()
                guard let text = textField.text else {
                    return
                }
                // 검색결과 확인
                guard let result = self.newlyWords[text.lowercased()] else {
                    let alert = UIAlertController(title: "", message: "검색 결과가 없습니다.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(okButton)
                    
                    self.indicatior.stopAnimating()
                    self.indicatior.removeFromSuperview()
                    self.enableButtons()
                    self.present(alert, animated: true, completion: nil)
                    print("검색 결과를 찾을 수 없습니다.")
                    return
                }
                self.valueLabel.text = result
                self.indicatior.stopAnimating()
                self.indicatior.removeFromSuperview()
                self.enableButtons()
            }
        }
        print("입력된 텍스트는 \(textField.text!) 입니다.")
        return true
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        // containerView의 서브 뷰들을 탐색
        for view in containerView.subviews {
            
            // 터치가 일어난 뷰가 containerView의 서브뷰일 경우
            if touch.view!.isDescendant(of: view) {
                print("touch container")
                return false
            }
        }
       
        self.view.endEditing(true)
        return true
    }
}
