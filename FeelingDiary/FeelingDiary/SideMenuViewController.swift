//
//  SideMenuViewController.swift
//  FeelingDiary
//
//  Created by 박연배 on 2021/10/06.
//

import UIKit
import SideMenu

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        print("Sidemenu viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Sidemenu viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Sidemenu viewWillDisappear")
    }

}
