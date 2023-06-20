//
//  TableViewCell.swift
//  Todo_List
//
//  Created by Taewon Yoon on 2023/06/20.
//

import UIKit

class TableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func textField(_ sender: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}
