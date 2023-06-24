//
//  TableViewCell.swift
//  Todo_List
//
//  Created by Taewon Yoon on 2023/06/20.
//

import UIKit
import CoreData

var itemArray = [Test]()
var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
var checkBox: [Bool] = []

protocol TableViewCellProtocol {
    func reload()
}

class TableViewCell: UITableViewCell, UITextFieldDelegate  {
    
    @IBOutlet var textfield: UITextField!
    @IBOutlet var checkImage: UIButton!
    
    var delegate: TableViewCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        textfield.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        context.reset()
        
        let newItem = Test(context: context)
        if(textField.text == ""){
            context.reset()
            checkBox.removeLast()
            itemArray.removeLast()
            print("지운다")
        } else {
            newItem.text = textField.text!
            itemArray[checkImage.tag] = newItem
            saveItems()
            print("저장한다ㅏㅏㅏㅏㅏ")
        }
//        print("reload시도")
        
        delegate?.reload()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        let item = checkBox[checkImage.tag]
        if item == false {
            print("\(checkImage.tag): \(item)")
            checkImage?.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            checkBox[checkImage.tag] = true
        } else {
//            print("안꽉채웠다")
            checkImage?.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            checkBox[checkImage.tag] = false
        }
    }
    
    
    func saveItems(){
        do {
            try context.save()
            print("저장됐다")
        } catch {
            print("Error saveing data, \(error)")
        }
    }
    
    func loadItems(){
        let request : NSFetchRequest<Test> = Test.fetchRequest()
        do {
            print("디버그1:\(itemArray.count)")
            itemArray = try context.fetch(request)
            print("디버그2:\(itemArray.count)")
        } catch {
            print("error \(error)")
        }
    }
}

