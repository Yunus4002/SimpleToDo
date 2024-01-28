//
//  EntryVC.swift
//  ToDoList
//
//  Created by Asadbek Muzaffarov on 28/01/24.
//

import UIKit



class EntryVC: UIViewController {

    @IBOutlet weak var textField: UITextField!{
        didSet {
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.borderWidth = 2.0
            textField.layer.cornerRadius = 12
        }
    }
    
    
    var update: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        title = "Create a task"
        
        createDoneButton()
    }
    
    
    private func createDoneButton() {
        let doneButton = UIBarButtonItem(title: "Done",
                                         image: nil,
                                         target: self,
                                         action: #selector(saveTask))
        navigationItem.rightBarButtonItem = doneButton
        
        
    }
    
    @objc func saveTask() {
        
        
        
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else { return }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)

    }
    
    

    
}

extension EntryVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        
        return true
    }
}
