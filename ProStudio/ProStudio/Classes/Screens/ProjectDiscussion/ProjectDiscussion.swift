//
//  ProjectDiscussionTableViewController.swift
//  ProStudio
//
//  Created by Zimma on 10/10/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class ProjectDiscussion: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = .clear
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            
            let cell  = Bundle.main.loadNibNamed("TextFieldCell", owner: self, options: nil)?.first as! TextFieldCell
            cell.textField.placeholderText = "Выберите вид проекта"
            cell.textField.tag = 0
            cell.textField.addRightButton()
            cell.textField.rightButton.addTarget(self, action: #selector(textFieldButtonAction(button:)), for: .touchUpInside)
            return cell
            
        } else if indexPath.row == 1 {
            
            let cell  = Bundle.main.loadNibNamed("TextFieldCell", owner: self, options: nil)?.first as! TextFieldCell
            cell.textField.placeholderText = "Имя"
            cell.textField.tag = 1
            
            return cell
            
        } else if indexPath.row == 2 {
            
            let cell  = Bundle.main.loadNibNamed("TextFieldCell", owner: self, options: nil)?.first as! TextFieldCell
            cell.textField.placeholderText = "Телефон"
            cell.textField.tag = 2
            
            return cell
            
        } else if indexPath.row == 3 {
            
            let cell  = Bundle.main.loadNibNamed("TextFieldCell", owner: self, options: nil)?.first as! TextFieldCell
            cell.textField.placeholderText = "Email"
            cell.textField.tag = 3
            
            return cell
            
        } else if indexPath.row == 4 {
            
            let cell  = Bundle.main.loadNibNamed("TextFieldCell", owner: self, options: nil)?.first as! TextFieldCell
            cell.textField.placeholderText = "Комментарий"
            cell.textField.tag = 4
            
            return cell
            
        } else {
            
            let cell  = Bundle.main.loadNibNamed("ButtonCell", owner: self, options: nil)?.first as! ButtonCell
            cell.button.setTitle("ОТПРАВИТЬ", for: .normal)
            cell.delegat = self
            
            return cell
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = (view.frame.height - 30) / 6
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        
    }
    
    @objc func textFieldButtonAction(button: UIButton) {
        
        print("This is button in textField!")
        
    }

}

extension ProjectDiscussion: ButtonCellDelegat {
    func didTaped() {
        
        print("Вот и отправили")
        
    }
    
    
}
