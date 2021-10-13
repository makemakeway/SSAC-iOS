//
//  ShoppingViewController.swift
//  TableViewPractice
//
//  Created by 박연배 on 2021/10/13.
//

import UIKit

class ShoppingViewController: UIViewController {

    
    //MARK: Property
    
    @IBOutlet weak var tableView: UITableView!
    
    var shoppingList: [ShoppingModel] = [] {
        didSet {
            self.tableView.reloadData()
            print(shoppingList)
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(shoppingList), forKey: "shoppingList")
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    //MARK: Method
    
    @IBAction func addList(_ sender: UIButton) {
        if !textField.text!.isEmpty {
            shoppingList.append(ShoppingModel(checked: false, text: textField.text!, stared: false))
            
        } else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func fetchList() {
        if let data = UserDefaults.standard.object(forKey: "shoppingList") as? Data {
            self.shoppingList = try! PropertyListDecoder().decode([ShoppingModel].self, from: data)
        }
        
    }
    
    @objc func checkButtonClicked(_ sender: UIButton) {
        print("\(sender.tag)번 버튼 눌림")
        shoppingList[sender.tag].checked.toggle()
        
        
    }
    
    @objc func starButtonClicked(_ sender: UIButton) {
        print("\(sender.tag)번 버튼 눌림")
        shoppingList[sender.tag].stared.toggle()
        
        
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        fetchList()
    }
    
}


//MARK: TableView Delegate
extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as? ShoppingTableViewCell else {
            
            print("기본 셀 반환")
            return UITableViewCell()
        }
        
        let data = shoppingList[indexPath.row]
        
        
        if data.checked {
            cell.checkMark?.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            cell.checkMark?.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        cell.checkMark?.tag = indexPath.row
        cell.checkMark?.addTarget(self, action: #selector(checkButtonClicked(_:)), for: .touchUpInside)
        
        cell.shoppingLabel?.text = data.text
        
        if data.stared {
            cell.starMark?.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.starMark?.setImage(UIImage(systemName: "star"), for: .normal)
        }
        cell.starMark?.tag = indexPath.row
        cell.starMark?.addTarget(self, action: #selector(starButtonClicked(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
        }
    }
}

//MARK: TextField Delegate
extension ShoppingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if !textField.text!.isEmpty {
            shoppingList.append(ShoppingModel(checked: false, text: textField.text!, stared: false))
        } else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            
        }
        
        return true
    }
}
