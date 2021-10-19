//
//  ViewController.swift
//  DrinkWater
//
//  Created by 박연배 on 2021/10/08.
//

import SnapKit
import UIKit

class DrinkWaterViewController: UIViewController {
    
    
    //MARK: Property
    var keyBoardState = false
    var totalWater = UserDefaults.standard.integer(forKey: "todayWater")
    var needToDrink = 2000
    var progress: Float = 0
    var nickname = "익명"
    var keyboardHeight: CGFloat = 0
    var mainImagePosition: CGFloat?
    
    @IBOutlet weak var feelingLabel: UILabel!
    
    @IBOutlet weak var constantLabel: UILabel!
    
    @IBOutlet weak var todayDrinking: UILabel!
    
    @IBOutlet weak var recommendedDrinking: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var drinkTextField: UITextField!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var drinkButton: UIButton!
    
    
    //MARK: Method
    
    // 초기화 버튼을 눌렀을 때
    @IBAction func resetButtonClicked(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        
        let alert = UIAlertController(title: nil, message: "오늘의 기록이 초기화됩니다. 진행하시겠습니까?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default) { _ in
            UserDefaults.standard.removeObject(forKey: "todayWater")
            self.totalWater = 0
            self.progressUpdate()
            self.fetchTodayWater()
            self.drinkTextField.text = ""
            self.feelingLabelUpdate()
            self.imageUpdate()
            print("초기화 완료!")
        }
        let cancelButton = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // 물 마시기 버튼을 눌렀을 때
    @IBAction func drinkWater(_ sender: UIButton) {
        guard let water = Int(drinkTextField.text!) else {
            makeAlert(message: "마신 물의 양을 입력해주세요.")
            return
        }
        let total = totalWater + water
        
        self.totalWater = total
        UserDefaults.standard.set(total, forKey: "todayWater")
        UserDefaults.standard.synchronize()
        
        self.fetchTodayWater()
        self.progressUpdate()
        self.feelingLabelUpdate()
        self.imageUpdate()
        
    }
    
    @IBAction func textLengthCheck(_ sender: UITextField) {
        checkMaxLength(textField: drinkTextField, maxLength: 4)
    }
    
    
    func makeAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    func headerLabelsConfig() {
        feelingLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        feelingLabel.textColor = .white
        
        constantLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        constantLabel.textColor = .white
        
        todayDrinking.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        todayDrinking.textColor = .white
        
        progressLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        progressLabel.textColor = .white
    }
    
    // 목표에 따라 이미지 뷰의 이미지 변경
    func imageUpdate() {
        let progress = Int((progress * 100).rounded())
        
        if progress < 30 {
            self.mainImage.image = UIImage(named: "1-1")
        }
        else if progress < 40 {
            self.mainImage.image = UIImage(named: "1-2")
        }
        else if progress < 50 {
            self.mainImage.image = UIImage(named: "1-3")
        }
        else if progress < 60 {
            self.mainImage.image = UIImage(named: "1-4")
        }
        else if progress < 70 {
            self.mainImage.image = UIImage(named: "1-5")
        }
        else if progress < 80 {
            self.mainImage.image = UIImage(named: "1-6")
        }
        else if progress < 90 {
            self.mainImage.image = UIImage(named: "1-7")
        }
        else if progress < 100 {
            self.mainImage.image = UIImage(named: "1-8")
        }
        else {
            self.mainImage.image = UIImage(named: "1-9")
        }
    }
    
    
    func progressUpdate() {
        progress = Float(totalWater) / Float(needToDrink)
        
        progressLabel.text = "목표의 \(Int((progress * 100).rounded()))%"
    }
    
    
    func drinkTextFieldConfig() {
        self.drinkTextField.keyboardType = .numberPad
    }
    
    
    func feelingLabelUpdate() {
        let progress = Int((progress * 100).rounded())
        if  progress == 0 {
            feelingLabel.text = "목이 마르지 않으신가요?"
            feelingLabel.textColor = .white
        }
        else if progress < 50 {
            feelingLabel.text = "잘하셨어요!"
            feelingLabel.textColor = .white
        }
        else if progress < 100 {
            feelingLabel.text = "훌륭해요!"
            feelingLabel.textColor = .white
        }
        else {
            feelingLabel.text = "완벽해요!"
            feelingLabel.textColor = UIColor.orange
        }
    }
    
    func recommendedLabelConfig() {
        recommendedDrinking.text = "\(nickname)님의 하루 물 권장 섭취량은 \(Double(needToDrink) / 1000.0)L입니다."
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
    
    func fetchTodayWater() {
        let water = UserDefaults.standard.integer(forKey: "todayWater")
        
        self.todayDrinking.text = String(water) + "ml"
    }
    
    func completeTodayDrink() {
        self.feelingLabel.textColor = UIColor.red
    }
    
    func mainImageAnimated() {
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse, .beginFromCurrentState]) {
            self.mainImage.transform = CGAffineTransform(translationX: 0, y: 0).scaledBy(x: 0.9, y: 0.9)
        }
    }
    
    func stopImageAnimate() {
        self.mainImage.layer.removeAllAnimations()
        self.mainImage.transform = .identity
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if drinkTextField.text!.count > maxLength {
            drinkTextField.deleteBackward()
        }
    }

    
    //MARK: Objc func
    
    @objc
    func keyboardWillShow(_ sender: Notification) {
        if keyBoardState == false {
            if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                keyboardHeight = keyboardRectangle.height
            }
            print("KEYBOARD APPEAR")
            
            
            
            drinkTextField.frame.origin.y -= keyboardHeight
            recommendedDrinking.frame.origin.y -= keyboardHeight
            drinkButton.frame.origin.y -= keyboardHeight
            
            for view in self.view.subviews {
                view.translatesAutoresizingMaskIntoConstraints = true
            }
            
            
            self.keyBoardState = true
        }
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
            
        }
        print(keyboardHeight)
        print("KEYBOARD Hide")
        
        
        
        drinkTextField.frame.origin.y += keyboardHeight
        recommendedDrinking.frame.origin.y += keyboardHeight
        drinkButton.frame.origin.y += keyboardHeight
        
        for view in self.view.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.keyBoardState = false
    }
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "background")
        self.navigationItem.title = "물 마시기"
        self.mainImagePosition = self.mainImage.frame.origin.y
        
        self.drinkTextField.delegate = self
        drinkTextFieldConfig()
        headerLabelsConfig()
        
        
        let gesture = UITapGestureRecognizer()
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserInfo()
        fetchTodayWater()
        progressUpdate()
        recommendedLabelConfig()
        print("viewWillappear")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
        self.view.endEditing(true)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        stopImageAnimate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageUpdate()
        feelingLabelUpdate()
        mainImageAnimated()
    }
    
}

//MARK: Extension

extension DrinkWaterViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing")
        UIView.animate(withDuration: 0.2) {
            self.mainImage.frame.origin.y = -500
        }
        return true
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        self.drinkTextField.resignFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.mainImage.frame.origin.y = self.mainImagePosition!
        }
    }
}

extension DrinkWaterViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.drinkTextField || touch.view == self.drinkButton {
            return false
        }
        self.view.endEditing(true)
        return true
    }
}
