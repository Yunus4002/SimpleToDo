//
//  MainVC.swift
//  ToDoList
//
//  Created by Asadbek Muzaffarov on 28/01/24.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        title = "Tasks"
        createAddButton()
        
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        // Getting all the data fetched up right after the view is loaded
        updateTasks()
            
        
    }
    // Avoiding headache in my ViewDidLoad function
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskTBC.nib(), forCellReuseIdentifier: TaskTBC.identifier)
        
    }
    
    func updateTasks() {
        
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x + 1)") as? String {
                tasks.append(task)
            }
        }
        tableView.reloadData()
        
    }
    
    
    private func createAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add
                                        ,
                                        target: self,
                                        action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addTapped() {
        
        let vc = EntryVC(nibName: "EntryVC", bundle: nil)
        
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
        
        
        
    }




}

extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TaskVC(nibName: "TaskVC", bundle: nil)
        
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    
    
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTBC.identifier, for: indexPath) as? TaskTBC else { return UITableViewCell() }
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    
    
    
}
