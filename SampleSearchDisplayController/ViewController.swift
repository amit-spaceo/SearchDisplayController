//
//  ViewController.swift
//  SampleSearchDisplayController
//
//  Created by Hitendra Mac on 14/04/17.
//  Copyright © 2017 Spaceo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tblSearch: UITableView!
    var searchController = UISearchController()

    var arrCountry = ["Afghanistan", "Algeria", "Bahrain","Brazil", "Cuba", "Denmark","Denmark", "Georgia", "Hong Kong", "Iceland", "India", "Japan", "Kuwait", "Nepal"];
    var arrFilter:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            //Add searchbar controller in header
            self.tblSearch.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        self.tblSearch.reloadData()
    }

    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.searchController.isActive) {
            return self.arrFilter.count
        } else {
            return self.arrCountry.count
        }

    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        configureCell(cell: cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: IndexPath) {
        // 3
        if (self.searchController.isActive) {
            cell.textLabel?.text = arrFilter[forRowAtIndexPath.row]
        } else {
            cell.textLabel?.text = arrCountry[forRowAtIndexPath.row]
        }
    }
    
    //UISearch result update delegate
    func updateSearchResults(for searchController: UISearchController) {
        arrFilter.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (arrCountry as NSArray).filtered(using: searchPredicate)
        arrFilter = array as! [String]
        
        self.tblSearch.reloadData()
    }
}

