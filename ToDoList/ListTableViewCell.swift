//
//  ListTableViewCell.swift
//  ToDoList
//
//  Created by Alexander Falcone on 3/28/20.
//  Copyright © 2020 Alexander Falcone. All rights reserved.
//

import UIKit

protocol ListTableViewCellDelegate: class {
    func checkBoxToggle(sender: ListTableViewCell)
}

class ListTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: ListTableViewCellDelegate?
    
    
    var toDoItem: ToDoItem! {
        didSet {
            nameLabel.text = toDoItem.name
            checkBoxButton.isSelected = toDoItem.completed
        }
    }

    @IBAction func checkToggled(_ sender: UIButton) {
        delegate?.checkBoxToggle(sender: self)
    }
    
    
}
