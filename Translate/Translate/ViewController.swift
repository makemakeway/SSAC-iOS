//
//  ViewController.swift
//  Translate
//
//  Created by 박연배 on 2021/10/27.
//

import UIKit

class ViewController: UIViewController {

    
    //MARK: Property
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var targetTextView: UITextView!
    
    
    //MARK: Method
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
        guard let value = textView.text else { return }
        TranslatedAPIManager.shared.fetchTranslateData(text: value) { code, json in
            switch code {
            case 200:
                print(json)
                self.targetTextView.text = json["message"]["result"]["translatedText"].stringValue
            case 400:
                print(json)
                self.targetTextView.text = json["errorMessage"].stringValue
            default:
                print("에러")
            }
        }
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

