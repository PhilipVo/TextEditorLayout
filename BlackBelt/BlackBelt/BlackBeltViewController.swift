//
//  ViewController.swift
//  BlackBelt
//
//  Created by Philip on 9/25/16.
//  Copyright © 2016 Philip Vo. All rights reserved.
//

import UIKit
import CoreData

let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

func save() {
    if managedObjectContext.hasChanges {
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
    }
}

class BlackBeltViewController: UITableViewController, CancelButtonDelegate, EntryDetailsViewControllerDelegate {

    var entries = [Entry]()
    
    func fetch() {
        let userRequest = NSFetchRequest(entityName: "Entry")
        
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            var entry_array = [Entry]()
            for result in results {
                let entry = result as! Entry
                if (entry.beasted == false) {
                    entry_array.append(entry)
                }
            }
            
            entries = entry_array
        } catch {
            print("\(error)")
        }
    }
    
    
    @IBAction func beastButtonPressed(sender: UIButton) {
        entries[sender.tag].beasted = true
        entries[sender.tag].beasted_date = NSDate()
        save()
        fetch()
        tableView.reloadData()
    }
    
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func entryDetailsViewController(controller: EntryDetailsViewController, addEntry details: String) {
        dismissViewControllerAnimated(true, completion: nil)
        if details.characters.count > 0 {
            let new_entry = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: managedObjectContext) as! Entry
            new_entry.details = details
            new_entry.beasted = false
            save()
            fetch()
            tableView.reloadData()
        }
    }
    
    func entryDetailsViewController(controller: EntryDetailsViewController, editEntry entry: Entry) {
        dismissViewControllerAnimated(true, completion: nil)
        save()
        fetch()
        tableView.reloadData()
    }
        
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        managedObjectContext.deleteObject(entries[indexPath.row])
        save()
        fetch()
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EntrySegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! EntryDetailsViewController
            controller.cancelButtonDelegate = self
            controller.entryDetailsDelegate = self
            
            if sender is UITableViewCell {
                if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                    controller.entryToEdit = entries[indexPath.row]
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("EntrySegue", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomCell
        cell.entryLabel.text = entries[indexPath.row].details
        cell.entryButton.tag = indexPath.row
        return cell
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

