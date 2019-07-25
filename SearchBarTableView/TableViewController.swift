//
//  TableViewController.swift
//  SearchBarTableView
//
//  Created by praveen Kumar on 16/05/19.
//  Copyright © 2019 praveen Kumar. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,UISearchResultsUpdating {
    
    //declaring global variables
    var searchController : UISearchController!
    var actors : [String]!
    var result : [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        actors = ["Rashmika Mandanna","Raashi Khanna","Kajal Aggarwal","Kriti Sanon","Kiara Advani","Alia Bhat","Priyanka Chopra","Deepika Padukone"]
        
        searchController = UISearchController(searchResultsController: nil)
        
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let storedData = actors[sourceIndexPath.row]
        actors.remove(at: sourceIndexPath.row)
        actors.insert(storedData, at: destinationIndexPath.row)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //print(searchController.searchBar.text!)
        
        let predicate = NSPredicate(format:"SELF contains[c] %@",searchController.searchBar.text!)
        
        result = (actors as NSArray).filtered(using: predicate) as? [String]
        
        tableView.reloadData()
        
        print("Hello WOrld")
        
        print(result!)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        var style = UITableViewCell.EditingStyle(rawValue: 1)
        
        if(indexPath.row % 2 == 0) {
            style = UITableViewCell.EditingStyle.insert
        } else {
            style = UITableViewCell.EditingStyle.delete
        }
        
        return style!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
            
        case UITableViewCell.EditingStyle.delete:
            actors.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            
        case UITableViewCell.EditingStyle.insert:
            actors.insert("Parineeti Chopra", at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            
        default:
            print("default")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rows = 0
        
        if(searchController.isActive) {
            rows = result.count
        } else {
            rows = actors.count
        }
        
        return rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if(searchController.isActive) {
            cell.textLabel?.text = result[indexPath.row]
        } else {
            cell.textLabel?.text = actors[indexPath.row]
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
