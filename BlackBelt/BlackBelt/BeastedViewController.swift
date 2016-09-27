//
//  ViewController.swift
//  BlackBelt
//
//  Created by Philip on 9/25/16.
//  Copyright © 2016 Philip Vo. All rights reserved.
//

import UIKit
import CoreData

class BeastedViewController: UITableViewController {

    var entries = [Entry]()
    
    func fetch() {
        let userRequest = NSFetchRequest(entityName: "Entry")
        
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            var entry_array = [Entry]()
            for result in results {
                let entry = result as! Entry
                if (entry.beasted == true) {
                    entry_array.append(entry)
                }
            }
            
            entries = entry_array
        } catch {
            print("\(error)")
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        managedObjectContext.deleteObject(entries[indexPath.row])
        save()
        fetch()
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BeastedCell") as UITableViewCell!
        cell.textLabel!.text = entries[indexPath.row].details
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd"
        cell.detailTextLabel!.text = dateFormatter.stringFromDate(entries[indexPath.row].beasted_date!)
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        fetch()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

