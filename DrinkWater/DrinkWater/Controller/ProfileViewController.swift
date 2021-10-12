//
//  ProfileViewController.swift
//  DrinkWater
//
//  Created by 박연배 on 2021/10/08.
//

import UIKit

class ProfileViewController: UIViewController {

    
    //MARK: Property
    
    var borderCompleted: Bool = false
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    
    //MARK: Method
    
    @IBAction func saveUserInfo(_ sender: UIBarButtonItem) {
        
        guard let nickname = nicknameTextField.text else {
            return
        }
        guard let height = Int(heightTextField.text!) else {
            makeAlert(message: "키는 숫자만 입력가능합니다.")
            return
        }
        
        guard let weight = Int(weightTextField.text!) else {
            makeAlert(message: "몸무게는 숫자만 입력가능합니다.")
            return
        }
        
        if nickname.isEmpty {
            makeAlert(message: "닉네임을 설정해주세요.")
        }
        else if String(height).isEmpty {
            makeAlert(message: "키를 설정해주세요.")
        }
        else if String(weight).isEmpty {
            makeAlert(message: "몸무게를 설정해주세요.")
        }
        
        
        let user = User(nickname: nickname, height: height, weight: weight)
        let ud = UserDefaults.standard
        ud.setValue(try? PropertyListEncoder().encode(user), forKey: "UserInfo")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func makeAlert(message: String) {
        let alert = UIAlertController(title: nil, message: "\(message)", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    
    func textFieldConfig(textfield: UITextField) {
        // 모든 border가 다 그려졌는지 판별하는 borderCompleted.
        // false상태면 border를 그려준다.
        if !borderCompleted {
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0, y: textfield.frame.height+2, width: textfield.frame.width-35, height: 2)
            bottomLine.backgroundColor = UIColor.white.cgColor
            textfield.layer.addSublayer(bottomLine)
            
            
            textfield.borderStyle = .none
            textfield.textColor = .white
            textfield.font = UIFont.systemFont(ofSize: 18)
        }
    }
    
    func fetchUserInfo() {
        guard let data = UserDefaults.standard.value(forKey: "UserInfo") as? Data else {
            print("data is missing")
            return
        }
        
        guard let userInfo = try? PropertyListDecoder().decode(User.self, from: data) else {
            print("Decoding Failed")
            return
        }
        
        nicknameTextField.text = userInfo.nickname
        heightTextField.text = String(userInfo.height)
        weightTextField.text = String(userInfo.weight)
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textFieldConfig(textfield: nicknameTextField)
        textFieldConfig(textfield: heightTextField)
        textFieldConfig(textfield: weightTextField)
        borderCompleted = true
    }

}
