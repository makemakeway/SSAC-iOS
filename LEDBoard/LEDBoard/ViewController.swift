//
//  ViewController.swift
//  LEDBoard
//
//  Created by 박연배 on 2021/10/01.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    //MARK: Property
    
    let colorPicker = UIColorPickerViewController()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = .white
        textField.clearButtonMode = .always
        textField.attributedPlaceholder = NSAttributedString(string: "입력",
                                                             attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        return textField
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 128, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var colorChangeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(changeColor(_:)), for: .touchUpInside)
        button.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        button.layer.borderWidth = 1
        return button
    }()
    
    
    //MARK: Method
    
    func textFieldConfig() {
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-100)
        }
    }
    
    func colorButtonConfig() {
        view.addSubview(colorChangeButton)
        
        colorChangeButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField.snp.centerY)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
            make.height.equalTo(textField.snp.height)
            make.width.equalTo(textField.snp.height)
        }
    }
    
    func labelConfig() {
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.leading.equalTo(view.snp.leading).offset(25)
            make.trailing.equalTo(view.snp.trailing).offset(-25)
            make.bottom.equalTo(view.snp.bottom).offset(-5).priority(250)
        }
    }
    
    
    //MARK: objc function
    @objc func changeColor(_ button: UIButton) {
        colorPicker.selectedColor = UIColor.cyan
        colorPicker.supportsAlpha = false
        self.present(colorPicker, animated: true, completion: nil)
    }
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        view.backgroundColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1.0)
        view.insetsLayoutMarginsFromSafeArea = false
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        
        colorPicker.delegate = self
        
        textFieldConfig()
        colorButtonConfig()
        labelConfig()
    }
}

//MARK: extensions
extension ViewController: UITextFieldDelegate {
    //키보드 리턴 눌렀을 때 실행되는 메소드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        label.text = textField.text
        textField.endEditing(true)
        return true
    }
}

extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        self.label.textColor = color
        self.colorChangeButton.backgroundColor = color
    }
}


//MARK: gestureRecognizer Delegate
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        // 터치한 view가 textField거나 colorChangeButton일 경우,
        // return false되어 아래에 있는 코드가 실행되지 않는다.
        if touch.view!.isDescendant(of: textField) || touch.view!.isDescendant(of: colorChangeButton) {
            return false
        }
        
        // 텍스트필드가 숨겨져 있지 않은 경우
        if self.textField.isHidden == false {
            self.textField.isHidden = true
            self.colorChangeButton.isHidden = true
            self.textField.endEditing(true)
            self.label.snp.remakeConstraints { make in
                make.center.equalTo(view.snp.center)
                make.leading.equalTo(view.snp.leading).offset(25)
                make.trailing.equalTo(view.snp.trailing).offset(-25)
            }
            
        }
        // 텍스트필드가 숨겨져 있는 경우
        else {
            self.textField.isHidden = false
            self.colorChangeButton.isHidden = false
            label.snp.remakeConstraints { make in
                make.top.equalTo(textField.snp.bottom)
                make.leading.equalTo(view.snp.leading).offset(25)
                make.trailing.equalTo(view.snp.trailing).offset(-25)
                make.bottom.equalTo(view.snp.bottom).offset(-5).priority(250)
            }
            self.textField.becomeFirstResponder()
        }
        return true
    }
}

import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController // 현재 뷰 컨트롤러의 이름
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
.previewInterfaceOrientation(.landscapeRight)
    }
}
