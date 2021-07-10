//
//  TableViewCell.swift
//  Birthday
//
//  Created by Клим on 04.07.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    func configure(with users: Users) {
        textLabel?.text = users.name
        detailTextLabel?.text = users.date
        
    }
}
