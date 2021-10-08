//
//  ProfileViewController.swift
//  DrinkWater
//
//  Created by 박연배 on 2021/10/08.
//

import UIKit

class ProfileViewController: UIViewController {

    
    //MARK: Property
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    
    //MARK: Method
    
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
    }
    

}
