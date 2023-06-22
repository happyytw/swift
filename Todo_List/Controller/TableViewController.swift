//
//  TableViewController.swift
//  Todo_List
//
//  Created by Taewon Yoon on 2023/06/20.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, UITextFieldDelegate, TableViewCellProtocol {
    
//    var itemArray = [Test]()
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ori")
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))) // 빈화면을 탭, 터치한다면
        tap.cancelsTouchesInView = false // 터치가 인식되었을때 취소하게끔 만든다.
        view.addGestureRecognizer(tap)
        
        
        
        
        loadItems()
        print("총개수: \(itemArray.count), \(checkBox.count)")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ori", for: indexPath) as! TableViewCell
        cell.delegate = self
//        let item = itemArray[indexPath.row]
        cell.textfield?.text = itemArray[indexPath.row].text
//
//        print("error1: checkBox[\(indexPath.row)] = \(checkBox[indexPath.row]), checked[\(checkBox[indexPath.row])]")
        let checked = checkBox[indexPath.row] // 눌렸는지 여부
        print("\(indexPath.row):\(checked)")
        if checked == true {
            cell.checkImage?.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            cell.checkImage?.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        cell.checkImage.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ori", for: indexPath) as! TableViewCell

        let item = checkBox[indexPath.row]
        if item == true {
//            print("꽉채웠다")
            cell.checkImage?.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            checkBox[indexPath.row] = false
        } else {
//            print("안꽉채웠다")
            cell.checkImage?.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            checkBox[indexPath.row] = true
        }
        
        tableView.reloadData()
        
//        saveItems()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
        let newItem = Test(context: context)
        newItem.text = ""
        
        itemArray.append(newItem)
        checkBox.append(false)
//        saveItems()
        tableView.reloadData()
    }
    
    func reload(){
        print("리로드됐다")
        loadItems()
        self.tableView.reloadData()
    }

    func saveItems(){
        do {
            try context.save()
        } catch {
            print("Error saveing data, \(error)")
        }
    }
    
    func loadItems(){
        let request : NSFetchRequest<Test> = Test.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("error \(error)")
        }
    }
}
