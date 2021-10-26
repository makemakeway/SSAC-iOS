//
//  ViewController.swift
//  LottoResult
//
//  Created by 박연배 on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    //MARK: Property
    
    var lottoData: LottoModel? {
        didSet {
            settingLayout()
        }
    }
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var countsLabel: UILabel!
    
    @IBOutlet weak var firstPrizeNumber: UILabel!
    @IBOutlet weak var firstNumberView: UIView!
    
    @IBOutlet weak var secondPrizeNumber: UILabel!
    @IBOutlet weak var secondNumberView: UIView!
    
    @IBOutlet weak var thirdPrizeNumber: UILabel!
    @IBOutlet weak var thirdNumberView: UIView!
    
    @IBOutlet weak var fourthPrizeNumber: UILabel!
    @IBOutlet weak var fourthNumberView: UIView!
    
    @IBOutlet weak var fifthPrizeNumber: UILabel!
    @IBOutlet weak var fifthNumberView: UIView!
    
    @IBOutlet weak var sixthPrizeNumber: UILabel!
    @IBOutlet weak var sixthNumberView: UIView!
    
    @IBOutlet weak var bonusPrizeNumber: UILabel!
    @IBOutlet weak var bonusNumberView: UIView!
    
    @IBOutlet weak var numbersStack: UIStackView!
    
    //MARK: Method
    
    func makeAlert(title: String?, message: String?, buttonTitle1: String, buttonTitle2: String, completion: @escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: buttonTitle1, style: .default) { _ in
            completion()
        }
        let cancelButton = UIAlertAction(title: buttonTitle2, style: .default, handler: nil)
        
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func fetchLottoData() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=903"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.lottoData = LottoModel(drwtNo1: json["drwtNo1"].intValue,
                                            drwtNo2: json["drwtNo2"].intValue,
                                            drwtNo3: json["drwtNo3"].intValue,
                                            drwtNo4: json["drwtNo4"].intValue,
                                            drwtNo5: json["drwtNo5"].intValue,
                                            drwtNo6: json["drwtNo6"].intValue,
                                            bnusNo: json["bnusNo"].intValue,
                                            drwNoDate: json["drwNoDate"].stringValue,
                                            drwNo: json["drwNo"].intValue)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func settingLayout() {
        guard let data = self.lottoData else {
            return
        }
        
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowRadius = 5
        headerView.layer.shadowOffset = .zero
        headerView.layer.shadowPath = UIBezierPath(rect: headerView.bounds).cgPath
        headerView.layer.shadowOpacity = 0.3
        
        settingBall(label: firstPrizeNumber, view: firstNumberView, num: data.drwtNo1)
        settingBall(label: secondPrizeNumber, view: secondNumberView, num: data.drwtNo2)
        settingBall(label: thirdPrizeNumber, view: thirdNumberView, num: data.drwtNo3)
        settingBall(label: fourthPrizeNumber, view: fourthNumberView, num: data.drwtNo4)
        settingBall(label: fifthPrizeNumber, view: fifthNumberView, num: data.drwtNo5)
        settingBall(label: sixthPrizeNumber, view: sixthNumberView, num: data.drwtNo6)
        settingBall(label: bonusPrizeNumber, view: bonusNumberView, num: data.bnusNo)
        
        self.countsLabel.text = String(data.drwNo) + "회"
        self.dateLabel.text = data.drwNoDate + " 추첨"
    }
    
    func settingBall(label: UILabel, view: UIView, num: Int) {
        let width = view.frame.size.width / 2
        
        label.textColor = .white
        label.text = String(num)
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        view.backgroundColor = pickBallColor(num: num)
        view.layer.cornerRadius = width
    }
    
    func pickBallColor(num: Int) -> UIColor {
        switch num {
        case 1..<10:
            return UIColor.orange
        case 10..<20:
            return UIColor.cyan
        case 20..<30:
            return UIColor.systemPink
        case 30..<45:
            return UIColor.lightGray
        default:
            return UIColor.darkGray
        }
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLottoData()
    }


}

