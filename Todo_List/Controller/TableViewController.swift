//
//  TableViewController.swift
//  Todo_List
//
//  Created by Taewon Yoon on 2023/06/20.
//

import UIKit
import CoreData

var currentRow: Int = 0

class TableViewController: UITableViewController, UITextFieldDelegate {
    
    var itemArray = [Test]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ori")
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))) // 빈화면을 탭, 터치한다면
        tap.cancelsTouchesInView = false // 터치가 인식되었을때 취소하게끔 만든다.
        view.addGestureRecognizer(tap)
        loadItems()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return  itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ori", for: indexPath) as! TableViewCell
        
        cell.textfield.text = itemArray[indexPath.row].text
        
        let item = itemArray[indexPath.row].done
//        cell.accessoryType = item ? .checkmark : .none
        if item {
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ori", for: indexPath) as? TableViewCell
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        saveItems()
        
        currentRow = indexPath.row
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
        let newItem = Test(context: self.context)
        newItem.text = ""
        
        self.itemArray.append(newItem)
        
        self.saveItems()
        
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
