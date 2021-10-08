//
//  ViewController.swift
//  DrinkWater
//
//  Created by 박연배 on 2021/10/08.
//

import UIKit

class DrinkWaterViewController: UIViewController {

    
    //MARK: Property
    var totalWater = 0
    var needToDrink = 2000
    var progress: Float = 0
    var nickname = ""
    
    
    @IBOutlet weak var feelingLabel: UILabel!
    
    @IBOutlet weak var todayDrinking: UILabel!
    
    @IBOutlet weak var recommendedDrinking: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var drinkTextField: UITextField!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    
    
    //MARK: Method
    
    // 초기화 버튼을 눌렀을 때
    @IBAction func resetButtonClicked(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: nil, message: "오늘의 기록이 초기화됩니다. 진행하시겠습니까?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default) { _ in
            self.totalWater = 0
            self.progressUpdate()
            self.feelingLabelUpdate()
            self.todayDrinkingUpdate()
            self.drinkTextField.text = ""
            self.imageUpdate()
            self.view.endEditing(true)
        }
        let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
        
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // 물 마시기 버튼을 눌렀을 때
    @IBAction func drinkWater(_ sender: UIButton) {
        guard let water = drinkTextField.text else {
            return
        }
        if water.isEmpty {
            print("마신 물의 양을 입력해주세요.")
        } else {
            totalWater += Int(water) ?? 0
            todayDrinkingUpdate()
            feelingLabelUpdate()
            progressUpdate()
            imageUpdate()
            print("물을 \(Int(water)!) 만큼 마셨습니다. 오늘 마신 물의 양은 \(totalWater)입니다.")
        }
    }
    
    // 목표에 따라 이미지 뷰의 이미지 변경
    func imageUpdate() {
        if Int((progress * 100).rounded()) < 30 {
            self.mainImage.image = UIImage(named: "1-1")
        }
        else if Int((progress * 100).rounded()) < 40 {
            self.mainImage.image = UIImage(named: "1-2")
        }
        else if Int((progress * 100).rounded()) < 50 {
            self.mainImage.image = UIImage(named: "1-3")
        }
        else if Int((progress * 100).rounded()) < 60 {
            self.mainImage.image = UIImage(named: "1-4")
        }
        else if Int((progress * 100).rounded()) < 70 {
            self.mainImage.image = UIImage(named: "1-5")
        }
        else if Int((progress * 100).rounded()) < 80 {
            self.mainImage.image = UIImage(named: "1-6")
        }
        else if Int((progress * 100).rounded()) < 90 {
            self.mainImage.image = UIImage(named: "1-7")
        }
        else if Int((progress * 100).rounded()) < 100 {
            self.mainImage.image = UIImage(named: "1-8")
        }
        else {
            self.mainImage.image = UIImage(named: "1-9")
        }
    }
    
    func todayDrinkingUpdate() {
        todayDrinking.text = "\(totalWater)ml"
    }
    
    func progressUpdate() {
        progress = Float(totalWater) / Float(needToDrink)
        
        progressLabel.text = "목표의 \(Int((progress * 100).rounded()))%"
    }
    
    
    func drinkTextFieldConfig() {
        self.drinkTextField.keyboardType = .numberPad
    }
    

    func feelingLabelUpdate() {
        if totalWater == 0 {
            feelingLabel.text = "목이 마르지 않으신가요?"
        }
        else if Int((progress * 100).rounded()) < 50 {
            feelingLabel.text = "잘하셨어요!"
        }
        else if Int((progress * 100).rounded()) < 100 {
            feelingLabel.text = "훌륭해요!"
        }
        else {
            feelingLabel.text = "완벽해요!"
        }
    }
    
    func recommendedLabelConfig() {
        recommendedDrinking.text = "\(nickname)님의 하루 물 권장 섭취량은 \(Double(Double(needToDrink) / 1000.0))L입니다."
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
        print(userInfo)
        
        self.needToDrink = (userInfo.height + userInfo.weight) * 10
        
        print(needToDrink)
        nickname = userInfo.nickname
    }
    
    func completeTodayDrink() {
        self.feelingLabel.textColor = UIColor.red
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "background")
        self.navigationItem.title = "물 마시기"
        self.drinkTextField.delegate = self
        drinkTextFieldConfig()
        
        
        let gesture = UITapGestureRecognizer()
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserInfo()
        todayDrinkingUpdate()
        feelingLabelUpdate()
        progressUpdate()
        imageUpdate()
        recommendedLabelConfig()
    }


}

//MARK: Extension

extension DrinkWaterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("\(textField.text ?? "") return")
        return true
    }
}

extension DrinkWaterViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.drinkTextField {
            return false
        }
        view.endEditing(true)
        return true
    }
}
