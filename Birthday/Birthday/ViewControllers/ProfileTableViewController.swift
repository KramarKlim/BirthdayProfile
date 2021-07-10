//
//  ProfileTableViewController.swift
//  Birthday
//
//  Created by Клим on 04.07.2021.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.fetchData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.shared.fetchData()
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataManager.shared.users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let user = DataManager.shared.users[indexPath.row]
        cell.configure(with: user)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DataManager.shared.deleteTask(for: indexPath.row)
        let deleteIndexPath = IndexPath(row: indexPath.row, section: 0)
        tableView.deleteRows(at: [deleteIndexPath], with: .automatic)
        tableView.reloadData()
    }
}


