//
//  LoginViewController.swift
//  SSACMovie
//
//  Created by 박연배 on 2021/09/30.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    //MARK: Property
    
    lazy var logo: UILabel = {
        let label = UILabel()
        label.text = "NETFLIX"
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        return label
    }()
    
    lazy var vStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insetsLayoutMarginsFromSafeArea = false
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insetsLayoutMarginsFromSafeArea = false
        return stackView
    }()
    
    lazy var emailOrNumber: UITextField = {
        let textField = makeTextField(placeholder: "이메일 주소 또는 전화번호")
        return textField
    }()
    
    lazy var password: UITextField = {
        let textField = makeTextField(placeholder: "비밀번호")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var nickname: UITextField = {
        let textField = makeTextField(placeholder: "닉네임")
        return textField
    }()
    
    lazy var location: UITextField = {
        let textField = makeTextField(placeholder: "위치")
        return textField
    }()
    
    lazy var recommendationCode: UITextField = {
        let textField = makeTextField(placeholder: "추천 코드 입력")
        textField.keyboardType = .numberPad
        return textField
    }()
    
    
    lazy var signInButton: UIButton = {
        let signIn = UIButton()
        signIn.backgroundColor = .white
        signIn.setTitle("회원가입", for: .normal)
        signIn.setTitleColor(.black, for: .normal)
        signIn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        signIn.isUserInteractionEnabled = true
        signIn.layer.cornerRadius = 5
        signIn.addTarget(self, action: #selector(self.signIn(_:)), for: .touchUpInside)
        
        return signIn
    }()
    
    lazy var additionalButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가 정보 입력", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var testSwitch: UISwitch = {
        let testSwitch = UISwitch()
        testSwitch.setOn(true, animated: true)
        testSwitch.onTintColor = .systemOrange
        testSwitch.thumbTintColor = .systemIndigo
        return testSwitch
    }()

    
    //MARK: Method
    func logoConfig() {
        view.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.centerX.equalTo(view)
        }
    }
    
    func vstackConfig() {
        view.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(100)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
    }
    
    func cellConfig() {
        vStack.addArrangedSubview(emailOrNumber)
        vStack.addArrangedSubview(password)
        vStack.addArrangedSubview(nickname)
        vStack.addArrangedSubview(location)
        vStack.addArrangedSubview(recommendationCode)
        vStack.addArrangedSubview(signInButton)
    }
    
    func footerConfig() {
        view.addSubview(hStack)
        
        hStack.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(vStack.snp.bottom).offset(20)
        }
        
        hStack.addArrangedSubview(additionalButton)
        hStack.addArrangedSubview(testSwitch)
    }
    
    func makeTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray4
        textField.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .semibold)])
        return textField
    }
    
    func emailStringCheck(string: String) -> Bool {
        let pattern = "^[A-z|0-9]*(@)[A-z]*(\\.)[A-z]*"
        let regex = try? NSRegularExpression(pattern: pattern)
        
        guard let result = regex?.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count)) else { return false }
        
        print(result)
        
        return true
    }
    
    func phoneNumberStringCheck(string: String) -> Bool {
        let pattern = "^01([0-9])([0-9]{3,4})([0-9]{4})$"
        let regex = try? NSRegularExpression(pattern: pattern)
        guard let result = regex?.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.count))
        else { return false }
        
        print(result)
        return true
    }
    
    //MARK: objc function
    @objc func signIn(_ button: UIButton) {
        let data = Auth(emailOrNumber: emailOrNumber.text, password: password.text, nickname: nickname.text, location: location.text, recommendationCode: recommendationCode.text)
        
        
        if data.emailOrNumber!.isEmpty {
            let alert = UIAlertController(title: "오류", message: "이메일 주소 혹은 전화번호를 입력해주세요.", preferredStyle: .alert)
            let button = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(button)
            return self.present(alert, animated: true, completion: nil)
        } else {
            if !emailStringCheck(string: data.emailOrNumber!) && !phoneNumberStringCheck(string: data.emailOrNumber!) {
                let alert = UIAlertController(title: "오류", message: "이메일 혹은 전화번호의 형식이 올바르지 않습니다.", preferredStyle: .alert)
                let button = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(button)
                return self.present(alert, animated: true, completion: nil)
            }
        }
        
        if data.password!.count < 6 {
            let alert = UIAlertController(title: "오류", message: "비밀번호는 6자리 이상 입력해주세요.", preferredStyle: .alert)
            let button = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(button)
            return self.present(alert, animated: true, completion: nil)
        }
        
        print("회원가입 정보 확인")
        print("ID: \(data.emailOrNumber ?? "")")
        print("PW: \(data.password ?? "")")
        print("NICK: \(data.nickname ?? "")")
        print("LOCATION: \(data.location ?? "")")
        print("CODE: \(data.recommendationCode ?? "")")
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.insetsLayoutMarginsFromSafeArea = false
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        logoConfig()
        vstackConfig()
        cellConfig()
        footerConfig()
        // Do any additional setup after loading the view.
    }
}


//MARK: Extension
extension LoginViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
