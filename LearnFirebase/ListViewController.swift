//
//  ListViewController.swift
//  LearnFirebase
//
//  Created by John Gallaugher on 4/15/17.
//  Copyright © 2017 Gallaugher. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var listArray = ["Exercise", "Garden", "Take daughter for bike ride"]

    @IBOutlet weak var addButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEditItem" {
            let destination = segue.destination as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            destination.listItem = listArray[indexPath.row]
        } else {
            if let selectedRow = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedRow, animated: true)
            }
        }
    }

    @IBAction func unwindFromDetail(sender: UIStoryboardSegue) {
        if let source = sender.source as? DetailViewController, let newItem = source.listItem {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let index = selectedIndexPath.row
                listArray[index] = newItem
            } else {
                listArray.append(newItem)
            }
            tableView.reloadData()
        } else {
            print("Error: Didn't come from DetailViewController or couldn't get listItem")
        }
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = listArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
