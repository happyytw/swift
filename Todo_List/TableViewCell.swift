//
//  TableViewCell.swift
//  Todo_List
//
//  Created by Taewon Yoon on 2023/06/20.
//

import UIKit

class TableViewCell: UITableViewCell, UITextFieldDelegate{
    
    @IBOutlet var textfield: UITextField!
    
    var itemArray = [Test]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func awakeFromNib() {
        super.awakeFromNib()
        print("abc")
        // Initialization code
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(TableViewCell.textFieldDidChange(_:)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("변화")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("끝")
        textField.isUserInteractionEnabled = false
        
        let newItem = Test(context: self.context)
        newItem.text = textField.text!
        
        self.itemArray.append(newItem)
        
        itemArray[currentRow].text = textField.text
        
        saveItems()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.textfield.resignFirstResponder()
    }
    
    func saveItems(){
        do {
            try context.save()
        } catch {
            print("Error saveing data, \(error)")
        }
    }
}

