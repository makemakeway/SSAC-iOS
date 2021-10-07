//
//  ViewController.swift
//  DdayCalculator
//
//  Created by 박연배 on 2021/10/07.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: Property
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko-KR")
        df.timeZone = TimeZone(identifier: "KST")
        df.dateFormat = "yyyy년\nMM월 dd일"
        
        return df
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.locale = Locale(identifier: "ko-KR")
        
        if #available(iOS 14.0, *) {
            picker.preferredDatePickerStyle = .inline
        } else {
            picker.preferredDatePickerStyle = .wheels
        }
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(dateValueChanged(_:)), for: .valueChanged)
        return picker
    }()
    
    lazy var firstDdayLabel: UILabel = {
        let label = dDayLabelConfig(title: "D+100")
        return label
    }()
    
    lazy var secondDdayLabel: UILabel = {
        let label = dDayLabelConfig(title: "D+200")
        return label
    }()
    
    lazy var thirdDdayLabel: UILabel = {
        let label = dDayLabelConfig(title: "D+300")
        return label
    }()
    
    lazy var fourthDdayLabel: UILabel = {
        let label = dDayLabelConfig(title: "D+400")
        return label
    }()
    
    lazy var firstDateLabel: UILabel = {
        let label = dateConfig()
        return label
    }()
    
    lazy var secondDateLabel: UILabel = {
        let label = dateConfig()
        return label
    }()
    
    lazy var thirdDateLabel: UILabel = {
        let label = dateConfig()
        return label
    }()
    
    lazy var fourthDateLabel: UILabel = {
        let label = dateConfig()
        return label
    }()
    
    lazy var firstImageView: UIImageView = {
        let imageView = imageConfig(image: "cake")
        return imageView
    }()
    
    lazy var secondImageView: UIImageView = {
        let imageView = imageConfig(image: "doughnut")
        return imageView
    }()
    
    lazy var thirdImageView: UIImageView = {
        let imageView = imageConfig(image: "churros")
        return imageView
    }()
    
    lazy var fourthImageView: UIImageView = {
        let imageView = imageConfig(image: "macaroon")
        return imageView
    }()
    
    lazy var vStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    //MARK: Method
    
    func dDayLabelConfig(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .white
        return label
    }
    
    func dateConfig() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }
    
    func imageConfig(image: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "\(image)")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    func datePickerConfig() {
        view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
            make.height.greaterThanOrEqualTo(60)
        }
    }
    
    func vStackConfig() {
        view.addSubview(vStack)
        
        vStack.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
            make.bottom.equalTo(view.snp.bottom).offset(-40)
        }
        
        
    }
    
    func hStackConfig() {
        let firstLine = makeHStack()
        let secondLine = makeHStack()
        
        vStack.addArrangedSubview(firstLine)
        vStack.addArrangedSubview(secondLine)
        
        firstLine.addArrangedSubview(makeCell(dday: firstDdayLabel,
                                              date: firstDateLabel,
                                              image: firstImageView))
        firstLine.addArrangedSubview(makeCell(dday: secondDdayLabel,
                                              date: secondDateLabel,
                                              image: secondImageView))
        
        secondLine.addArrangedSubview(makeCell(dday: thirdDdayLabel,
                                               date: thirdDateLabel,
                                               image: thirdImageView))
        secondLine.addArrangedSubview(makeCell(dday: fourthDdayLabel,
                                               date: fourthDateLabel,
                                               image: fourthImageView))
    }
    
    func makeHStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        
        stack.spacing = 20
        
        return stack
    }
    
    func makeCell(dday: UILabel, date: UILabel ,image: UIImageView) -> UIImageView {
        
        // 글자들이 잘 보이게 이미지 뷰 위에 덧씌울 뷰.
        let opacityView = UIView()
        opacityView.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        
        image.layer.cornerRadius = 10
        
        image.addSubview(opacityView)
        image.addSubview(dday)
        image.addSubview(date)
        
        opacityView.snp.makeConstraints { make in
            make.width.equalTo(image.snp.width)
            make.height.equalTo(image.snp.height)
        }
        
        dday.snp.makeConstraints { make in
            make.top.equalTo(image.snp.top).offset(10)
            make.leading.equalTo(image.snp.leading).offset(10)
        }
        
        date.snp.makeConstraints { make in
            make.center.equalTo(image.snp.center)
        }
        
        return image
    }
    
    func dateSetting(date: Date) {
        let afterHundred = Date(timeInterval: 86400 * 99, since: date)
        let afterTwoHundreds = Date(timeInterval: 86400 * 199, since: date)
        let afterThreeHundreds = Date(timeInterval: 86400 * 299, since: date)
        let afterFourHundreds = Date(timeInterval: 86400 * 399, since: date)
        
        firstDateLabel.text = dateFormatter.string(from: afterHundred)
        secondDateLabel.text = dateFormatter.string(from: afterTwoHundreds)
        thirdDateLabel.text = dateFormatter.string(from: afterThreeHundreds)
        fourthDateLabel.text = dateFormatter.string(from: afterFourHundreds)
    }
    
    //MARK: Objc function
    @objc func dateValueChanged(_ sender: UIDatePicker) {
        dateSetting(date: sender.date)
    }
    
    
    //MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        datePickerConfig()
        vStackConfig()
        hStackConfig()
        dateSetting(date: Date())
    }


}
