//
//  TabBarController.swift
//  SSACfood
//
//  Created by 박연배 on 2021/10/05.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
    }
    
    
    private func setUpTabBar() {
        let homeViewController = UINavigationController(rootViewController: ViewController())
        homeViewController.tabBarItem.image = UIImage(systemName: "house") // TabBar Item 의 이미지
        homeViewController.tabBarItem.title = "홈" // TabBar Item 의 이름
        
        let secondViewController = UINavigationController(rootViewController: SecondViewController())
        secondViewController.tabBarItem.image = UIImage(systemName: "heart")
        secondViewController.tabBarItem.title = "찜한가게"
        
        let thirdViewController = UINavigationController(rootViewController: ThirdViewController())
        thirdViewController.tabBarItem.image = UIImage(systemName: "doc.text")
        thirdViewController.tabBarItem.title = "주문내역"
        
        let fourthViewController = UINavigationController(rootViewController: FourthViewController())
        fourthViewController.tabBarItem.image = UIImage(systemName: "person")
        fourthViewController.tabBarItem.title = "my배민"
        
        viewControllers = [homeViewController,
                           secondViewController,
                           thirdViewController,
                           fourthViewController]
    }
}
