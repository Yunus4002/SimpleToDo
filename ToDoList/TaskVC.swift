//
//  TaskVC.swift
//  ToDoList
//
//  Created by Asadbek Muzaffarov on 28/01/24.
//

import UIKit

class TaskVC: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    
    var task: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = task
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            title: "Delete",
//            image: nil,
//            target: self,
//            action: #selector(deleteTaskTapped))
    }
    
    @objc func deleteTaskTapped() {
        

        
    }

    
    

 

}
