//
//  SecondViewController.swift
//  SSACfood
//
//  Created by 박연배 on 2021/09/29.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        content.text = "안녕하세요\n반갑습니다"
        content.numberOfLines = 2
        content.font = UIFont.boldSystemFont(ofSize: 20)
        content.textAlignment = .center
        content.backgroundColor = .systemOrange
        content.textColor = .systemIndigo
        content.layer.cornerRadius = 10
        content.clipsToBounds = true
        
        checkButton.backgroundColor = .systemIndigo
        checkButton.setTitle("행운의 번호를 뽑아보세요", for: .normal)
        checkButton.setTitle("뽑아뽑아", for: .highlighted)
        checkButton.layer.cornerRadius = 10
        checkButton.setTitleColor(UIColor.systemOrange, for: .normal)
        checkButton.setTitleColor(UIColor.systemOrange, for: .highlighted)
    }

    @IBAction func checkButtonClicked(_ sender: UIButton) {
        let randomNumber = Int.random(in: 1...45)
        content.text = "행운의 번호는 \(randomNumber)입니다!"
    }
}
