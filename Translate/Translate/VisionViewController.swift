//
//  VisionViewController.swift
//  Translate
//
//  Created by 박연배 on 2021/10/27.
//

import UIKit

class VisionViewController: UIViewController {

    
    
    //MARK: Property
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    //MARK: Method
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        guard let image = postImageView.image else { return }
        
        VisionAPIManager.shared.fetchFaceData(image: image) { code, json in
            print(json)
        }
        
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}
