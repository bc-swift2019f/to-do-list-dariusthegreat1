//
//  ViewController.swift
//  List App
//
//  Created by Nick Haidari on 9/22/19.
//  Copyright © 2019 Nick Haidari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var toDoArray = ["Learn swift","build apps","change the world"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem" {
            let destination = segue.destination as! DetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            destination.toDoItem = toDoArray[index]
        }else{
            if let selectedPath = tableView.indexPathForSelectedRow{
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue){
        let sourceViewController = segue.source as! DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            toDoArray[indexPath.row] = sourceViewController.toDoItem!
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }else{
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            toDoArray.append(sourceViewController.toDoItem!)
            tableView.insertRows(at: [newIndexPath], with: .automatic )
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
    {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
        
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        return cell
    }
}

